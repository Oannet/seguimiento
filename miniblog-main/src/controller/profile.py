import functools
import os
from flask import (render_template, Blueprint, g, redirect, request, session, url_for, flash)
from werkzeug.security import check_password_hash, generate_password_hash
from werkzeug.utils import secure_filename
from src.controller.auth import requires_login

# Maped rows to objects
from src.model.user import User
from src.model.post import Post
# import querys
from src.model.repo import *
from src import app

# Endpoint para la función de autenticación y registro de usuarios
profile = Blueprint('profile', __name__, url_prefix='/profile')

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@profile.route('/<user>', methods=['GET', 'POST'])
@requires_login
def main(user):
    '''Gets the user information and can update info when update'''
    if user != session['user']:
        flash('You are not authorized to view this profile.')
        return redirect(url_for('home.main'))

    user = get_user(user)
    
    if request.method == 'POST':
        first_name = request.form.get('first_name')
        second_name = request.form.get('second_name')
        birthday = request.form.get('birthday')
        old_password = request.form.get('old_password')
        new_password = request.form.get('new_password')

        # Validación básica
        if not first_name or not second_name:
            flash('First name and second name are required')
            return redirect(url_for('profile.main', user=user.username))

        user.first_name = first_name
        user.second_name = second_name
        user.birthday = birthday

        # Manejo de contraseñas con hashing seguro
        if old_password and new_password:
            if check_password_hash(user.password, old_password):
                user.password = generate_password_hash(new_password)
            else:
                flash('Las contraseñas no coinciden')

        add(user)
    return render_template('blog/profile.html', user=user)

@profile.route('/create', methods=['GET', 'POST'])
@requires_login
def create():
    '''This person creates a post'''
    if request.method == 'POST':
        title = request.form.get('title')
        text = request.form.get('text').strip()
        img = request.files['img']
        access = 'access' in request.form

        # Validación de datos
        if not title or not text:
            flash('Title and text are required')
            return redirect(url_for('profile.create'))

        post = Post(title, text, access)
        post.author = session['user']

        # Validar archivo de imagen
        if img and allowed_file(img.filename):
            filename = secure_filename(img.filename)
            abs_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            img.save(abs_path)
            post.img = abs_path[5+8:]  # LMAO (asegúrate de que este ajuste sea necesario)
        else:
            flash('Invalid image format')

        add(post)
        return redirect(url_for('home.main'))

    return render_template('blog/create.html')

@profile.route('/update/<int:id_post>', methods=['GET', 'POST'])
@requires_login
def update(id_post):
    '''Updates a post by this user'''
    post = get_post_by_id(id_post)
    
    # Validar que el usuario tenga permisos para modificar el post
    if post.author != session['user']:
        flash('You are not authorized to modify this post')
        return redirect(url_for('home.main'))

    if request.method == 'POST':
        title = request.form.get('title')
        text = request.form.get('text').strip()

        # Validación de datos
        if not title or not text:
            flash('Title and text are required')
            return redirect(url_for('profile.update', id_post=id_post))

        post.title = title
        post.text = text
        add(post)
        return redirect(url_for('home.main'))
    
    return render_template('blog/update.html', post=post)

@profile.route('/delete/<int:id_post>', methods=['GET', 'POST'])
@requires_login
def delete(id_post):
    '''Deletes a post by this user'''
    post = get_post_by_id(id_post)

    # Validar que el usuario tenga permisos para eliminar el post
    if post.author != session['user']:
        flash('You are not authorized to delete this post')
        return redirect(url_for('home.main'))

    remove(post)
    return redirect(url_for('profile.main', user=post.author))
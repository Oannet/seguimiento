import functools, os, datetime, requests, json

from flask import (jsonify, render_template, Blueprint, g, redirect, request, session, url_for)

from werkzeug.utils import secure_filename
from src.controller.auth import requires_login

# Mapeo de filas a objetos
from src.model.user import User
from src.model.post import Post
from src.model.repo import *
from src import app

# Endpoint para la función de autenticación y registro de usuarios
home = Blueprint('home', __name__, url_prefix='/home')

@home.route('/', methods=['GET', 'POST'])
@requires_login
def main():
    '''Method to get the feed'''
    posts = list(get_all_public_posts())[::-1]
    birthdays = get_birthdays(30)
    
    api_url = 'https://catfact.ninja/fact'
    
    # Manejo de errores para la API
    try:
        response = requests.get(api_url, timeout=5)
        response.raise_for_status()
        response = json.loads(response.content.decode('utf8'))
    except (requests.exceptions.RequestException, json.JSONDecodeError):
        response = {"fact": "No data available"}  # Respuesta por defecto en caso de error
    
    return render_template('blog/home.html', posts=posts, birthdays=birthdays, today=datetime.datetime.now(), response=response)

@home.route('/<user>/<access>', methods=['GET'])
def my_posts(user, access):
    '''Función para obtener los posts de un usuario según el tipo de acceso'''
    if access not in ['private', 'public']:
        return jsonify({"error": "Invalid access type"}), 400
    if access == 'private' and user != session.get('user').strip().lower():
        return jsonify({"error": "Unauthorized access"}), 401
    
    access_bool = False if access == 'private' else True
    posts = list(get_posts_by_access(user, access_bool))[::-1]
    birthdays = get_birthdays(30)
    
    # Definir la URL de la API dentro de la función
    api_url = 'https://catfact.ninja/fact'
    
    # Manejo de errores para la API
    try:
        response = requests.get(api_url, timeout=5)
        response.raise_for_status()
        response = json.loads(response.content.decode('utf8'))
    except (requests.exceptions.RequestException, json.JSONDecodeError):
        response = {"fact": "No data available"}  # Respuesta por defecto en caso de error
    
    today = datetime.datetime.now()
    
    return render_template('blog/home.html', posts=posts, birthdays=birthdays, today=today, response=response)

@home.route('/<int:id_post>')
@requires_login
def post(id_post):
    '''Obtiene un solo post y realiza operaciones sobre él'''
    post = get_post_by_id(id_post)
    if not post:
        return jsonify({"error": "Post not found"}), 404
    
    api_url = 'https://catfact.ninja/fact'
    
    try:
        response = requests.get(api_url, timeout=5)
        response.raise_for_status()
        response = json.loads(response.content.decode('utf8'))
    except (requests.exceptions.RequestException, json.JSONDecodeError):
        response = {"fact": "No data available"}
    
    birthdays = get_birthdays(30)
    today = datetime.datetime.now()
    
    return render_template('blog/post.html', post=post, id_post=id_post, birthdays=birthdays, response=response, today=today)

@home.route('/like', methods=['POST'])
@requires_login
def like():
    '''Método para enviar un like cuando se presiona el botón de like'''
    if request.method == 'POST':
        body = request.json
        id_post = body['id']
        post = get_post_by_id(id_post)
        post.likes += 1
        add(post)
    return redirect(url_for('home.post', id_post=id_post))

@home.route('/get-likes/<int:id_post>', methods=['GET'])
@requires_login
def get_likes(id_post):
    '''Método para obtener el número actual de likes en el post'''
    post = get_post_by_id(id_post)
    if not post:
        return jsonify({"error": "Post not found"}), 404
    
    response = {'id': post.id, 'likes': post.likes}
    return jsonify(response)

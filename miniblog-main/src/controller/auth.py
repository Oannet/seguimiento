import functools
from flask import (
    render_template,
    Blueprint,
    g,
    flash,
    redirect,
    request,
    session,
    url_for
)
# security hashes for passwords **
from werkzeug.security import generate_password_hash, check_password_hash

# Maped rows to objects
from src.model.user import User
# import querys
from src.model.repo import *
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

# Endpoint para la función de autenticación y registro de usuarios
auth = Blueprint('auth', __name__, url_prefix='/auth')
limiter = Limiter(get_remote_address, default_limits=["200 per day", "50 per hour"])

@auth.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        first_name = request.form.get('first_name')
        second_name = request.form.get('second_name')
        birthday = request.form.get('birthday')

        # Validación básica
        if not username or not password:
            flash('Username and password are required')
            return render_template('auth/register.html')

        user = get_user(username)
        if not user:
            # Almacenar la contraseña con un hash seguro
            hashed_password = generate_password_hash(password)
            user = User(username,
                        hashed_password,
                        first_name,
                        second_name,
                        birthday)
            add(user)
            return redirect(url_for('home.main'))
        
        err = 'Username already exists!'
        flash(err)
    return render_template('auth/register.html')


@auth.route('/login', methods=['GET', 'POST'])
@limiter.limit("5 per minute")  # Limitar intentos de login
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        # Validar credenciales y usar hash para comparación de contraseñas
        if validate_user_and_password(username, password):
            session.clear()
            session.permanent = True  # Activar sesiones temporales con expiración
            session['user'] = username
            return redirect(url_for('home.main'))
        else:
            err = 'Wrong user or password'
            flash(err)
    return render_template('auth/login.html')

@auth.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('main'))

@auth.before_app_request
def verify_user():
    '''En cada petición, verificamos que el usuario esté activo'''
    user = session.get('user')
    g.user = user if user else None

def requires_login(foo):
    '''Verifica que hay un login antes de ejecutar el endpoint'''
    @functools.wraps(foo)
    def wrapper(**kwargs):
        if g.user:
            return foo(**kwargs)
        return redirect(url_for('main'))
    return wrapper
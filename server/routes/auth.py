import uuid
import bcrypt
import jwt
from fastapi import APIRouter, Depends, HTTPException, Header
from database import get_db
from middlewares.auth_middleware import auth_middleware
from models.user import User
from pydantic_schemas.user_signin import UserSignin
from pydantic_schemas.user_signup import UserSignup
from sqlalchemy.orm import Session

router = APIRouter()

@router.post('/signup', status_code = 201)
def signup_user(user: UserSignup, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(400, 'User with the same email already exists!')
    user_db = User(id = str(uuid.uuid4()), name = user.name, email = user.email, password = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt()))
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return user_db

@router.post('/signin')
def signin_user(user: UserSignin, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    if not user_db:
        raise HTTPException(400, 'User with this email dosn\'t exists!')
    is_match = bcrypt.checkpw(user.password.encode(), user_db.password)
    if not is_match:
        raise HTTPException(400, 'Password is incorrect!')
    token = jwt.encode({'id': user_db.id}, 'password_key')
    return {'token': token, 'user': user_db}

@router.get('/')
def get_user_data(db: Session = Depends(get_db), user_dict = Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).first()
    if not user:
        raise HTTPException(404, 'User not found!')
    return user
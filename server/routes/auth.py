import uuid
import bcrypt
from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from sqlalchemy.orm import Session

router = APIRouter()

@router.post('/signup')
def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(400, 'User with the same email already exists!')
    user_db = User(id = str(uuid.uuid4()), name = user.name, email = user.email, password = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt()))
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    return user_db
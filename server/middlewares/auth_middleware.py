import os
from dotenv import load_dotenv
import jwt
from fastapi import HTTPException, Header

def auth_middleware( x_auth_token = Header()):
    try:
        load_dotenv()
        if not x_auth_token:
            raise HTTPException(401, 'No auth token, access denied!')
        token = jwt.decode(x_auth_token, os.getenv("PASSWORD_KEY"), ['HS256'])
        if not token:
            raise HTTPException(401, 'Token verification failed, authorization denied!')
        uid = token.get('id')
        return {'uid': uid, 'token': x_auth_token}
    except jwt.PyJWTError:
        raise HTTPException(401, 'Token verification failed, authorization denied!')
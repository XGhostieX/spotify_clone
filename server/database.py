from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URl = 'postgresql://postgres:2573@localhost:5432/spotify'

engine = create_engine(DATABASE_URl)
SessionLocal = sessionmaker(bind = engine, autocommit = False, autoflush = False)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

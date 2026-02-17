from pydantic import BaseModel


class FavoriteSong(BaseModel):
    id: str
    
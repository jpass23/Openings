from pydantic import BaseModel
from datetime import datetime

class FetchResponse(BaseModel):
    count: int
    last: None
    items: list

class Message(BaseModel):
    #date: datetime
    name: str
    subject: str
    email: str
    message: str

    def toDict(self): 
        return {"name": self.name, "subject": self.subject, "email": self.email, "message": self.message}

    @classmethod
    def fromDict(self, d: dict):
        return Message(name=d["name"], subject=d["subject"], email=d["email"], message=d["message"])

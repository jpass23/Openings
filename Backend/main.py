from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, RedirectResponse
from deta import Deta
from models import Message, FetchResponse

db_key = "b0ye31lna9a_4aQyhB2frDigrK9PG3awtMTzDU12htp1"
deta = Deta(db_key)
db = deta.Base("messages")

app = FastAPI()

@app.get("/")
def root():
    return {"Hello": "World"}

@app.get("/get-messages")
def get_message_list() -> list[Message]:
    table: FetchResponse = db.fetch()
    messages: list[Message] = []
    for item in table.items:
        messages.append(Message.fromDict(item["message"]))
    return messages

@app.get("/add/")
def add_message(name: str, email: str, subject: str, message: str) -> bool:
    message: Message = Message(name=name, email=email, subject=subject, message=message)
    message = {"message" : message.toDict()}
    try:
        db.put(message)
        return True
    except:
        return False

@app.delete("/message_from/{name}")
def delete_message(name: str):
    messages: FetchResponse = db.fetch().items
    for message in messages:
        if message["message"]["name"] == name:
            try:
                db.delete(message["key"])
                return {"ok" : True}
            except:
                return {"ok" : False}

@app.delete("/clear-db/")
def clear_db():
    messages: FetchResponse = db.fetch().items
    try:
        for message in messages:
            db.delete(message["key"])
        return {"ok" : True}
    except:
        return {"ok" : False}
        
    
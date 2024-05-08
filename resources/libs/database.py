from robot.api.deco import keyword
from pymongo import MongoClient
import  bcrypt

client = MongoClient('mongodb+srv://qa:xperience@cluster0.iclpeoh.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')

db = client['markdb']

# Removendo um usuário
@keyword('Remove user database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email':email})
    print(email +' FOI REMOVIDO!')

@keyword('Insert user database')

# Inserindo um usuário
def insert_user(user):
    
    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'),bcrypt.gensalt(8))

    doc={
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }
    users = db['users']
    users.insert_one(doc)


# Apagando toda uma tabela
@keyword('Drop table users')
def drop_user():
    users = db['users']
    users.drop()
    print('A tabela FOI REMOVIDA!')


# Apagando o usuário e as tarefas associadas
@keyword('Clean user from database')
def clean_user(user_email):

    users = db['users']
    tasks = db['tasks']

    user = users.find_one({'email': user_email})

    if(user):
        tasks.delete_many({'user':user['_id']})
        users.delete_many({'email':user_email})


# Buscando um usuário e inserindo uma tarefa a ele
@keyword('Insert task user')
def insert_task(user_email, user_task):

    task = db['tasks']
    users = db['users']

    user = users.find_one({'email':user_email})

    if(user):
        task_data = {'user': user['_id'],'name': user_task }

        task.insert_one(task_data)
        print(task_data)
        print('sucesso ao inserir')

    else:
        print('usuário não encontrado!!')
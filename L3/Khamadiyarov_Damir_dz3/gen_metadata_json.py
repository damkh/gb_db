import json
import random
import string


def random_string(string_length):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(string_length))


# Количество необходимых записей для таблицы media в колонку metadata
row_num = 150
# Генерация рандомных данных и SQL запроса
for idx in range(1, row_num + 1):
    friends = [
            {'opt1': random_string(4), 'opt2': [random_string(4), random.randint(1, 100)]},
            {'opt3': random_string(6), 'opt4': random.randint(0, 20)}
        ]
    json_data = json.dumps(friends)
    to_sql = f'UPDATE media SET metadata=\'{json_data}\' WHERE id = {idx};'
    print(to_sql)

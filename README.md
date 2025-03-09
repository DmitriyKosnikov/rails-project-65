### Hexlet tests and linter status:
[![Actions Status](https://github.com/DmitriyKosnikov/rails-project-65/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/DmitriyKosnikov/rails-project-65/actions)


[![Lint Status](https://github.com/DmitriyKosnikov/rails-project-64/actions/workflows/linter.yml/badge.svg)](https://github.com/DmitriyKosnikov/rails-project-64/actions/workflows/linter.yml)

---
### Link to site:
Проект развернут на [Render](https://render.com).  
Ссылка на приложение: (https://bulletin-board-peqe.onrender.com)

---

### Описание
Это доска объявлений которая позволяет пользователю создавать свои объявления.
После создания объявления пользователь должен отправить его на модерацию в разделе "Мои объявления".
После просмотра администратором ваше объявление может опубликовано, либо возвращено на доработку, либо отправлено в архив. Также сам пользователь может отправить его в архив в любой момент времени.

Загружаемые файлы(фотографии) могут быть не более 5 мб в объеме а также форматов png или jpeg.

Также проект включает систему авторизации через github.

---

### Требования
- Ruby `3.2.2`
- Rails `7.2.2`
- PostgreSQL `14+` или SQLite3
- Хранение файлов реализовано через yandex cloud

---

### Установка

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/DmitriyKosnikov/rails-project-65.git
   cd rails-project-65
   ```

2. Установите зависимости:
   ```bash
   bundle install
   yarn install
   ```

3. Настройте базу данных. Укажите свои данные в файле `config/database.yml` для PostgreSQL  
   или используйте SQLite3, добавив следующее в `config/database.yml`:
   ```yaml
   development:
     <<: *default
     adapter: sqlite3
   ```

4. Выполните команды для настройки базы данных:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed # не забудьте раскомментировать содержание файла db/seed.rb
   ```

---

### Использование

Для запуска приложения перейдите в директорию проекта и выполните:
```bash
bin/dev
```

---

### Тестирование

Для запуска тестов используйте команду:
```bash
make test
```

В проекте используются:  
- `Minitest`  
- `minitest-power_assert`
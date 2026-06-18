# Используем официальный Node.js образ
FROM node:18-alpine

# Устанавливаем SQLite (нужен для работы базы данных)
RUN apk add --no-cache sqlite

# Создаём рабочую директорию
WORKDIR /usr/src/app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь код
COPY . .

# Создаём папки для данных и фото
RUN mkdir -p /usr/src/app/data/uploads && \
    chown -R node:node /usr/src/app

# Переключаемся на пользователя node (безопасность)
USER node

# Открываем порт
EXPOSE 3000

# Запускаем сервер
CMD ["node", "server.js"]
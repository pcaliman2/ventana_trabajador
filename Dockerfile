# =========================
# STAGE 1: Build de Flutter Web
# =========================
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos TODO el proyecto Flutter al contenedor
COPY . .

# Habilitar web (por si la imagen no lo trae activo)
RUN flutter config --enable-web

# Descargar dependencias
RUN flutter pub get

# Build web en modo release
RUN flutter build web --release

# =========================
# STAGE 2: Servir con Nginx
# =========================
FROM nginx:alpine

# Copiamos el build generado en el stage anterior
COPY --from=build /app/build/web /usr/share/nginx/html

# Exponemos el puerto 80 (Nginx)
EXPOSE 80

# Comando por defecto: levantar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]

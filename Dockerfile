FROM php:8.2-apache

# Cài đặt PHP extension
RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN a2enmod rewrite

# Thêm ServerName vào Apache để tránh cảnh báo
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Đặt index.php làm trang mặc định
RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

WORKDIR /var/www/html

# Sao chép mã nguồn vào container
COPY ./odms /var/www/html/

# Phân quyền cho thư mục mã nguồn
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Mở cổng 80 cho HTTP
EXPOSE 80

# Khởi động Apache
CMD ["apache2-foreground"]
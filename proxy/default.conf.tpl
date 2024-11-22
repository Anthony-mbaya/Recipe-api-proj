#server {
#    listen ${LISTEN_PORT};
#
#    location /static {
#        alias /vol/static;
#    }
#
#   location / {
#        uwsgi_pass              ${APP_HOST}:${APP_PORT};
#        include                 /etc/nginx/uwsgi_params;
#        client_max_body_size    10M;
#    }
#}
server {
    listen 80;
    server_name ec2-54-88-162-126.compute-1.amazonaws.com;

    location / {
        return 301 https://$host$request_uri;
        proxy_pass http://recipe-api-proj_proxy_1:8000; # Assuming your Django app is running on this port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # Enable CORS
    add_header Access-Control-Allow-Origin https://recipe-app-react-pi.vercel.app;
    add_header Access-Control-Allow-Methods "GET, POST, OPTIONS, DELETE, PUT";
    add_header Access-Control-Allow-Headers "Content-Type, Authorization";
}

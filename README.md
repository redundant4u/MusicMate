# MusicMate
주위 친구들은 어떤 음악을 들을까? 친구들이 즐겨 듣는 음악 리스트 확인해보세요.

## Server setting
```
git clone https://github.com/redundant4u/MusicMate
cd MusicMate/Server
./setting.sh
```
## Caution
셋팅되는 환경에 따라 실행이 안 될수도 있습니다. [docker-compose.yml](https://github.com/redundant4u/MusicMate/blob/main/Server/docker-compose.yml), [app.dockerfile](https://github.com/redundant4u/MusicMate/blob/main/Server/configuration/app/app.dockerfile), [uwsgi.ini](https://github.com/redundant4u/MusicMate/blob/main/Server/volumes/uwsgi.ini) 파일을 수정하여 자신의 환경에 맞춰주세요. 특히 권한에 대해서 조심하셔야합니다.

[default.conf](https://github.com/redundant4u/MusicMate/blob/main/Server/configuration/web/conf.d/default.conf) 파일을 수정하셔서 SSL 적용 및 도메인 주소를 입력해주세요.

web 컨테이너로 접속한 후 직접 certbot을 통하여 SSL을 적용시켜줘야 합니다. 또한 횐경설정에 맞춰 Server/configuraion/web/conf.d/default.conf 파일에서 server_name 값을 수정해주세요. 다음은 certbot을 통한 SSL 적용 명령어입니다.
```
docker-exec -it web sh
certbot --nginx -d [DOMAIN.com] -d [www.DOMAIN.com]
```

빈 sqlite DB로 설정되어 있으니 migration과 migrate를 진행해주셔야 합니다.
```
docker-exec -it app bash
python manage.py makemigrations api
python manage.py migrate
```

[api](https://github.com/redundant4u/MusicMate/tree/main/Server/volumes/api) 디렉터리 안에 key.py를 만들어 장고의 secret key, 스포티파이의 client key, secret key 값이 정의되어야합니다.

## Structure overview
<img src="https://user-images.githubusercontent.com/38307839/131053506-e9c17243-b3fc-4e3b-919b-c20bb08177e8.png" alt="pics">
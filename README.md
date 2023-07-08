# pay_cutter
Capstore Project :eyes:

A Mobile Application for manage revenue and expenditure in a group, run in Flutter and NodeJS - ExpressJS :fire:

To build and run this application, follow these steps below:


## Backend

1. Change directory to backend source:
```bash
cd backend
```

2. Instal NodeJS on Ubuntu
```bash
sudo apt install nodejs
```

3. Get Node Modules to  `backend/node_modules`
```bash
npm install
```

4. Setup enviroment base on `example.env` (edit some variable like Database URL, JWT Secret Key... )
```bash
touch .env
nano .env
```

5. Run the backend server on Port 3000 in Developer Mode with Nodemon
```bash
npm install -g nodemon
nodemon src/app.ts
```

6. Run the backend server on Port 3000 in Production Mode with PM2
```bash
npm install -g pm2
pm2 start run.sh
```
Check if the server run successful :rocket: :
```bash
curl localhost:3000
```

7. Setup nginx to host the server :hammer:
```bash
sudo apt-get update
sudo apt instal nginx
sudo ufw allow 'Nginx HTTP'
systemctl status nginx
sudo nano /etc/nginx/sites-available/default
```
Copy and Paste that Config below, then press Ctrl + X to save
```config
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                proxy_pass http://localhost:3000;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }
}
```

Restart to apply this config
```bash
systemctl restart nginx
```

## Mobile App
1. Install the Flutter SDK
```bash
sudo snap install flutter --classic
flutter doctor
export PATH="$PATH:[PATH_OF_FLUTTER_GIT_DIRECTORY]/bin"
echo $PATH
flutter doctor --android-licenses
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

2. Change directory to Mobile App
```bash
cd ~/mobile
```

3. Config the config.json file base env_example.json (Change `BASE_URL` to the Server URL config in the backend)
```bash
touch config.json
nano config.json
```

4. Config the Google Maps API Key
```bash
cd android
echo "MAPS_API_KEY=<Your Key>" >> local.properties
flutter pub get
```
Change `<Your Key>` to Your Google Maps API Key

5. Build the Android App
```bash
flutter build apk --release --flavor prod --dart-defines-from-file=config.json
```

Flutter will build an APK file in `mobile/build/app/outputs/apk`, install the file in Android device :iphone:

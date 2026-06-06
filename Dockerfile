FROM python:3.12-slim 

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt # 캐시 저장하지 않음으로써 이미지 크기를 줄임

COPY . .

CMD ["gunicorn", "-w", "2", "-k", "uvicorn.workers.UvicornWorker", "main:app", "--bind", "0.0.0.0:8080"]
# FROM : 베이스 이미지
# 컨테이너 시작 시 실행할 명령어
# -w 2 : 워커 프로세스 2개
# -k uvicorn.workers.UvicornWorker : 비동기 처리 가능한 워커 타입
# main:app : main.py 파일의 app객체
# --bind 0.0.0.0:8080 : 모든 IP의 8080포트로 수신
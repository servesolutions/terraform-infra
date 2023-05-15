FROM python:3.9
EXPOSE 8080
COPY game.html /
COPY requirements.txt .
RUN pip install -r requirements.txt
CMD python -m http.server 8080
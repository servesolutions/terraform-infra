FROM python:3.9
EXPOSE 8080
COPY tictactoe.py /
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "tictactoe.py"]
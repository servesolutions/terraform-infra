FROM python:3.9
COPY tictactoe.py /
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "tictactoe.py"]
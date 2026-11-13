from django.db import models


class Board(models.Model):
    mno = models.AutoField(primary_key=True,blank=True)
    poster = models.ImageField(upload_to="board")
    title = models.CharField(max_length=200)
    story = models.TextField()
    genre = models.CharField(max_length=20)
    director = models.CharField(max_length=100)
    actor1 = models.CharField(max_length=100)
    actor2 = models.CharField(max_length=100)
    actor3 = models.CharField(max_length=100)
    release_date = models.DateField()

    def __str__(self):
        return f'{self.mno},{self.title},{self.release_date}'
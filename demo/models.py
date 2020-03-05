from django.contrib.gis.db import models


class Place(models.Model):
    name = models.CharField(max_length=126)
    position = models.PointField(geography=True)

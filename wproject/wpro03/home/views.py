from django.shortcuts import render
from django.http import JsonResponse
import joblib
import os
from pathlib import Path
import numpy as np
from scipy.special import softmax

def index(request):
    return render(request, 'index.html')

def ajax_data(request):
    return JsonRespones(context)
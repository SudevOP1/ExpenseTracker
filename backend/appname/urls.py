from django.urls import path
from . import views

urlpatterns = [
    path("create-expense/", views.create_expense, name="create_expense"),
    path("get-expenses/",   views.get_expenses,   name="get_expenses"),
    path("update-expense/", views.update_expense, name="update_expense"),
    path("delete-expense/", views.delete_expense, name="delete_expense"),
]

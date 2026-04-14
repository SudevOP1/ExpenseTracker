from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from datetime import datetime
import json

from .models import ExpenseModel

@csrf_exempt
def create_expense(request) -> JsonResponse:
    try:

        if request.method == "POST":
            body = json.loads(request.body)
            name = body.get("name")
            cost = body.get("cost")
            desc = body.get("desc")
            
            expense = ExpenseModel.objects.create(
                name=name,
                cost=cost,
                desc=desc,
            )
            
            return JsonResponse({
                "success": True,
                "expense": {
                    "id": expense.id,
                    "name": expense.name,
                    "cost": expense.cost,
                    "desc": expense.desc,
                    "datetime": expense.datetime,
                },
            })
        
        else:
            return JsonResponse({
                "success": False,
                "error": "only POST request allowed",
            })
        
    except Exception as e:
        return JsonResponse({
            "success": False,
            "error": f"something went wrong: {str(e)}",
        })

@csrf_exempt
def get_expenses(request) -> JsonResponse:
    try:

        if request.method == "GET":

            expenses = ExpenseModel.objects.all()

            from_date = request.GET.get("from", None)
            to_date = request.GET.get("to", None)

            if from_date:
                from_date = datetime.strftime(from_date, "%Y-%m-%d")
                expenses = expenses.filter(date__gte=from_date)
            if to_date:
                to_date = datetime.strftime(to_date, "%Y-%m-%d")
                expenses = expenses.filter(date__lte=to_date)

            expenses = [
                {
                    "id": expense.id,
                    "name": expense.name,
                    "cost": expense.cost,
                    "desc": expense.desc,
                    "datetime": expense.datetime,
                }
                for expense in expenses
            ]

            return JsonResponse({
                "success": True,
                "expenses": expenses,
            })
        
        else:
            return JsonResponse({
                "success": False,
                "error": "only GET request allowed",
            })
        
    except Exception as e:
        return JsonResponse({
            "success": False,
            "error": f"something went wrong: {str(e)}",
        })

@csrf_exempt
def update_expense(request) -> JsonResponse:
    try:

        if request.method == "PUT":
            body = json.loads(request.body)
            id   = body.get("id")
            name = body.get("name", None)
            cost = body.get("cost", None)
            desc = body.get("desc", None)

            expense = ExpenseModel.objects.get(id=id)
            if name is not None: expense.name = name
            if cost is not None: expense.cost = cost
            if desc is not None: expense.desc = desc
            expense.save()

            return JsonResponse({
                "success": True,
                "expense": {
                    "id": expense.id,
                    "name": expense.name,
                    "cost": expense.cost,
                    "desc": expense.desc,
                    "datetime": expense.datetime,
                },
            })
        
        else:
            return JsonResponse({
                "success": False,
                "error": "only PUT request allowed",
            })
        
    except Exception as e:
        return JsonResponse({
            "success": False,
            "error": f"something went wrong: {str(e)}",
        })

@csrf_exempt
def delete_expense(request):
    try:

        if request.method == "DELETE":
            body = json.loads(request.body)
            id   = body.get("id")

            expense = ExpenseModel.objects.get(id=id)
            expense.delete()

            return JsonResponse({ "success": True, })
        
        else:
            return JsonResponse({
                "success": False,
                "error": "only DELETE request allowed",
            })
        
    except Exception as e:
        return JsonResponse({
            "success": False,
            "error": f"something went wrong: {str(e)}",
        })

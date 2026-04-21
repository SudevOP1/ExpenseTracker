# Creating a dictionary
capitals = {
    "USA": "Washington D.C.",
    "India": "New Delhi",
    "China": "Beijing",
    "Russia": "Moscow"
}

print(capitals)

# # 1. Accessing values
# print(capitals["India"])          # New Delhi
# print(capitals.get("China"))     # Beijing

# # 2. Adding new key-value pair
# capitals["Japan"] = "Tokyo"

# # 3. Updating a value
# capitals["USA"] = "Washington"

# # 4. Removing items
# capitals.pop("Russia")           # Removes Russia

# # 5. Check if key exists
# if "India" in capitals:
#     print("India exists")
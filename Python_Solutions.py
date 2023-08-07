import json
from collections import defaultdict
from typing import List, Dict

def process_data(customers_file: str, transactions_file: str, products_file: str) -> List[Dict]:
    # Load customers and create a dictionary to store customer data
    customers = {}
    with open(customers_file, 'r') as f:
        for line in f:
            customer = json.loads(line)
            customers[customer['customer_id']] = customer

    # Process transactions and update customer data
    with open(transactions_file, 'r') as f:
        for line in f:
            transaction = json.loads(line)
            customer_id = transaction['customer_id']
            customers[customer_id]['purchase_count'] += 1
            products = transaction['basket']
            for product in products:
                product_category = product['product_category']
                customers[customer_id]['products'][product_category].append(product['product_id'])

    # Load product categories
    product_categories = {}
    with open(products_file, 'r') as f:
        for line in f:
            product = json.loads(line)
            product_categories[product['product_id']] = product['product_category']

    # Prepare the final output
    output = []
    for customer_id, customer_data in customers.items():
        loyalty_score = customer_data['loyalty_score']
        purchase_count = customer_data['purchase_count']
        products = customer_data['products']
        for category, product_ids in products.items():
            for product_id in product_ids:
                output.append({
                    'customer_id': customer_id,
                    'loyalty_score': loyalty_score,
                    'product_id': product_id,
                    'product_category': product_categories[product_id],
                    'purchase_count': purchase_count
                })

    return output

if __name__ == "__main__":
    customers_file = "./input_data/starter/customers.jsonl"
    transactions_file = "./input_data/starter/transactions"
    products_file = "./input_data/starter/products.jsonl"

    result = process_data(customers_file, transactions_file, products_file)

    with open("output.json", "w") as f:
        json.dump(result, f, indent=2)

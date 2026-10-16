# Superstore Database ERD

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    ORDERS ||--|{ ORDER_DETAILS : contains
    PRODUCTS ||--o{ ORDER_DETAILS : appears_in

    CUSTOMERS {
        string customer_id PK
        string customer_name
        string segment
    }

    ORDERS {
        string order_id PK
        string customer_id FK
        string order_date
        string ship_date
        string ship_mode
        string city
        string state
        string region
    }

    PRODUCTS {
        string product_id PK
        string product_name
        string category
        string sub_category
    }

    ORDER_DETAILS {
        integer order_detail_id PK
        string order_id FK
        string product_id FK
        real sales
        integer quantity
        real discount
        real profit
    }
```

The customers table connects to orders through customer_id.
The orders table connects to order_details through order_id.
The products table connects to order_details through product_id.

class DataList {

  static List<Map<String, dynamic>> productList = [
    {
      "id": 1,
      "name": "Product 1",
      "series_number": "001",
    },
    {
      "id": 2,
      "name": "Product 2",
      "series_number": "002",
    },
    {
      "id": 3,
      "name": "Product 3",
      "series_number": "003",
    },
  ];

  static List<Map<String ,dynamic>> warehouseList = [
    {
      "id": 1,
      "name": "Warehouse 1",
      "address": "Address 1",
    },
    {
      "id": 2,
      "name": "Warehouse 2",
      "address": "Address 2",
    },
    {
      "id": 3,
      "name": "Warehouse 3",
      "address": "Address 3",
    },
  ];

  static List<Map<String,dynamic>> itemsList = [
    {
      "productId": 1,
      "productType":"Printer",
      "subMenu":[
        {
          "id": 1,
          "name": "printer 1",
          "series_number": "001",
          "selected_items":1,
          "quantity": 25,
          "price": 400,
          "total_price": 400,
        },
        {
          "id": 2,
          "name": "printer 2",
          "series_number": "002",
          "selected_items":1,
          "quantity": 100,
          "price": 249,
          "total_price": 249,
        }
      ]
    },
    {
      "productId": 2,
      "productType":"Monitor",
      "subMenu":[
        {
          "id": 1,
          "name": "Monitor 1",
          "series_number": "003",
          "selected_items":1,
          "quantity": 25,
          "price": 400,
          "total_price": 400
        },
        {
          "id": 2,
          "name": "Monitor 2",
          "series_number": "004",
          "selected_items":1,
          "quantity": 100,
          "price": 400,
          "total_price": 400,
        }
      ]
    },
    {
      "productId": 3,
      "productType":"Cable",
      "subMenu":[
        {
          "id": 1,
          "name": "Cable 1",
          "series_number": "005",
          "selected_items":1,
          "quantity": 25,
          "price": 400,
          "total_price": 400,
        },
        {
          "id": 2,
          "name": "Cable 2",
          "series_number": "006",
          "selected_items":1,
          "quantity": 100,
          "price": 400,
          "total_price": 400,
        },
      ]
    },
    {
      "productId": 4,
      "productType":"Printer",
      "subMenu":[
        {
          "id": 1,
          "name": "printer 1",
          "series_number": "007",
          "selected_items":1,
          "quantity": 25,
          "price": 400,
          "total_price": 400,
        },
        {
          "id": 2,
          "name": "printer 2",
          "series_number": "008",
          "selected_items":1,
          "quantity": 100,
          "price": 249,
          "total_price": 249,
        }
      ]
    },
    {
      "productId": 5,
      "productType":"Printer",
      "subMenu":[
        {
          "id": 1,
          "name": "printer 1",
          "series_number": "009",
          "selected_items":1,
          "quantity": 25,
          "price": 400,
          "total_price": 400,
        },
        {
          "id": 2,
          "name": "printer 2",
          "series_number": "010",
          "selected_items":1,
          "quantity": 100,
          "price": 249,
          "total_price": 249,
        }
      ]
    }
  ];
}
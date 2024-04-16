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
          "id": 11,
          "name": "printer 1",
          "series_number": "001",
          "quantity": 0,
        },
        {
          "id": 12,
          "name": "printer 2",
          "series_number": "002",
          "quantity": 0,
        }
      ]
    },
    {
      "productId": 2,
      "productType":"Monitor",
      "subMenu":[
        {
          "id": 21,
          "name": "Monitor 1",
          "series_number": "003",
          "quantity": 0,
        },
        {
          "id": 22,
          "name": "Monitor 2",
          "series_number": "004",
          "quantity": 0,
         }
      ]
    },
    {
      "productId": 3,
      "productType":"Cable",
      "subMenu":[
        {
          "id": 31,
          "name": "Cable 1",
          "series_number": "005",
          "quantity": 0,
        },
        {
          "id": 32,
          "name": "Cable 2",
          "series_number": "006",
          "quantity": 0,
        },
      ]
    },
    {
      "productId": 4,
      "productType":"Printer",
      "subMenu":[
        {
          "id": 41,
          "name": "printer 1",
          "series_number": "007",
          "quantity": 0,
        },
        {
          "id": 42,
          "name": "printer 2",
          "series_number": "008",
          "quantity": 0,
        }
      ]
    },
    {
      "productId": 5,
      "productType":"Printer",
      "subMenu":[
        {
          "id": 51,
          "name": "printer 1",
          "series_number": "009",
          "quantity": 0,
        },
        {
          "id": 52,
          "name": "printer 2",
          "series_number": "010",
          "quantity": 0,
        }
      ]
    }
  ];
}
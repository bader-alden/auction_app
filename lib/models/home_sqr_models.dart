class home_squer_models{
  String? name;
  String? price;
  int? id;
  home_squer_models.fromjson(Map<String,dynamic>json){
    name = json["name"];
    price = json["price"];
    id = json["id"];
  }
}
List<home_squer_models> test_sqr = [
  home_squer_models.fromjson({'name':'bader','price':'5000','id':1}),
  home_squer_models.fromjson({'name':'أنا','price':'4000','id':2}),
  home_squer_models.fromjson({'name':'خالد','price':'10000','id':3}),
  home_squer_models.fromjson({'name':'me','price':'200','id':4}),
  home_squer_models.fromjson({'name':'عبدو','price':'50','id':5})

];
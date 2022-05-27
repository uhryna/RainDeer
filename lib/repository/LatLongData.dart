/// name : "Lviv"
/// local_names : {"it":"Leopoli","ka":"ლვოვი","hr":"Lavov","ro":"Liov","eo":"Lvivo","et":"Lviv","uk":"Львів","sk":"Ľvov","ar":"لفيف","nl":"Lviv","zh":"利維夫","lt":"Lvovas","pl":"Lwów","tr":"Lviv","sr":"Лавов","ca":"Lviv","ko":"리비우","cs":"Lvov","de":"Lemberg","en":"Lviv","be":"Львоў","he":"לבוב","fr":"Lviv","ru":"Львов","hu":"Lviv","lv":"Ļvova","io":"Lviv","hy":"Լվով","es":"Leópolis","la":"Leopolis","sl":"Lvov","pt":"Leópolis"}
/// lat : 49.841952
/// lon : 24.0315921
/// country : "UA"
/// state : "Lviv Oblast"

class LatLongData {
  String? name;
  LocalNames? localNames;
  double? lat; //TODO переробити
  double? lon;  //TODO переробити
  String? country;
  String? state;

  LatLongData(
      {this.name,
        this.localNames,
        required this.lat,
        required this.lon,
        this.country,
        this.state});

  factory LatLongData.fact(lat, lon,){
    return LatLongData(lat: lat, lon: lon);
  }

  LatLongData.fromJson(Map<String, dynamic> json) { //TODO переробити під фекторі констрк
    name = json['name'];
    localNames = json['local_names'] != null
        ? new LocalNames.fromJson(json['local_names'])
        : null;
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.localNames != null) {
      data['local_names'] = this.localNames!.toJson();
    }
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['country'] = this.country;
    data['state'] = this.state;
    return data;
  }
}

class LocalNames {
  String? it;
  String? ka;
  String? hr;
  String? ro;
  String? eo;
  String? et;
  String? uk;
  String? sk;
  String? ar;
  String? nl;
  String? zh;
  String? lt;
  String? pl;
  String? tr;
  String? sr;
  String? ca;
  String? ko;
  String? cs;
  String? de;
  String? en;
  String? be;
  String? he;
  String? fr;
  String? ru;
  String? hu;
  String? lv;
  String? io;
  String? hy;
  String? es;
  String? la;
  String? sl;
  String? pt;

  LocalNames(
      {this.it,
        this.ka,
        this.hr,
        this.ro,
        this.eo,
        this.et,
        this.uk,
        this.sk,
        this.ar,
        this.nl,
        this.zh,
        this.lt,
        this.pl,
        this.tr,
        this.sr,
        this.ca,
        this.ko,
        this.cs,
        this.de,
        this.en,
        this.be,
        this.he,
        this.fr,
        this.ru,
        this.hu,
        this.lv,
        this.io,
        this.hy,
        this.es,
        this.la,
        this.sl,
        this.pt});

  LocalNames.fromJson(Map<String, dynamic> json) {
    it = json['it'];
    ka = json['ka'];
    hr = json['hr'];
    ro = json['ro'];
    eo = json['eo'];
    et = json['et'];
    uk = json['uk'];
    sk = json['sk'];
    ar = json['ar'];
    nl = json['nl'];
    zh = json['zh'];
    lt = json['lt'];
    pl = json['pl'];
    tr = json['tr'];
    sr = json['sr'];
    ca = json['ca'];
    ko = json['ko'];
    cs = json['cs'];
    de = json['de'];
    en = json['en'];
    be = json['be'];
    he = json['he'];
    fr = json['fr'];
    ru = json['ru'];
    hu = json['hu'];
    lv = json['lv'];
    io = json['io'];
    hy = json['hy'];
    es = json['es'];
    la = json['la'];
    sl = json['sl'];
    pt = json['pt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['it'] = this.it;
    data['ka'] = this.ka;
    data['hr'] = this.hr;
    data['ro'] = this.ro;
    data['eo'] = this.eo;
    data['et'] = this.et;
    data['uk'] = this.uk;
    data['sk'] = this.sk;
    data['ar'] = this.ar;
    data['nl'] = this.nl;
    data['zh'] = this.zh;
    data['lt'] = this.lt;
    data['pl'] = this.pl;
    data['tr'] = this.tr;
    data['sr'] = this.sr;
    data['ca'] = this.ca;
    data['ko'] = this.ko;
    data['cs'] = this.cs;
    data['de'] = this.de;
    data['en'] = this.en;
    data['be'] = this.be;
    data['he'] = this.he;
    data['fr'] = this.fr;
    data['ru'] = this.ru;
    data['hu'] = this.hu;
    data['lv'] = this.lv;
    data['io'] = this.io;
    data['hy'] = this.hy;
    data['es'] = this.es;
    data['la'] = this.la;
    data['sl'] = this.sl;
    data['pt'] = this.pt;
    return data;
  }
}
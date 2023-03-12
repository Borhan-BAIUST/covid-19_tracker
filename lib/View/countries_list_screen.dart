import 'package:covid19_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
StatesServices statesServices = StatesServices();
    return Scaffold(
      //backgroundColor: Colors.black,
     appBar: AppBar(
       elevation: 0,
       backgroundColor:Colors.black
     ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              TextFormField(
                controller: _searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
              SizedBox(height: 8,),
              Expanded(child: FutureBuilder(
                future: statesServices.gethcountryRecordList(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                  if(!snapshot.hasData){
                    return  Center(child: CircularProgressIndicator());

                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                        String countryName = snapshot.data![index]["country"];
                        if(_searchController.text.isEmpty){
                          return Card(
                            color: Colors.grey.shade400,
                            child:Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 80,
                                  child: Image(
                                    image: NetworkImage(
                                        snapshot.data![index][ "countryInfo"][ "flag"]
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(  snapshot.data![index][ "country"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),

                                    Text("Total Cases : ${snapshot.data![index]["cases"]}"),
                                    // Text("Today Cases : ${snapshot.data![index]["todayCases"]}"),
                                    Text("Total Deaths : ${snapshot.data![index]["deaths"]}"),
                                    // Text("Today Deaths: ${snapshot.data![index][  "todayDeaths"]}"),

                                  ],
                                )
                              ],
                            ),
                          );
                        }else if(countryName.toLowerCase().contains(_searchController.text.toLowerCase())){
                          return Card(
                            color: Colors.grey.shade400,
                            child:Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 80,
                                  child: Image(
                                    image: NetworkImage(
                                        snapshot.data![index][ "countryInfo"][ "flag"]
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(  snapshot.data![index][ "country"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),

                                    Text("Total Cases : ${snapshot.data![index]["cases"]}"),
                                    // Text("Today Cases : ${snapshot.data![index]["todayCases"]}"),
                                    Text("Total Deaths : ${snapshot.data![index]["deaths"]}"),
                                    // Text("Today Deaths: ${snapshot.data![index][  "todayDeaths"]}"),

                                  ],
                                )
                              ],
                            ),
                          );
                        }else{
                          return Container();
                        }

                    });

                  }

                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar.dart';
import 'home.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthai/Register.dart';
import 'package:healthai/services/auth.dart';
import 'email_conformation.dart';
import 'main.dart';
import 'models/loginuser.dart';
import 'package:flutter/material.dart';
import 'Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SignUp.dart';
import 'home.dart';
import 'forgotpass.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'models/loginuser.dart';
import 'services/auth.dart';
import 'models/FirebaseUser.dart';
import 'screens/wrapper.dart';

const List<String> list = <String>["TYPHOID FEVER","STOMACH ULCER","ASTHMA","RHEUMATISM / ARTHRITIS","CHOLERA","HIGH BLOOD PRESSURE","PNEUMONIA","SEVERE COUGH","TUBERCULOSIS","DIABETES","STAPHYLOCOCCUS","WOMAN UNDER HARD LABOUR","INTERNAL PILE","MENSTRUATION PROBLEM","WEIGHT LOSS","FUNGAL INFECTION","GONORRHEA","INTERNAL HEAT","INSOMNIA","HEART FAILURE","TEETHING PROBLEMS IN CHILDREN","LOW SPERM COUNT","QUICK EJACULATION","WEAK ERECTION","VIRGINAL DISCHARGE","CHILDREN CONVULSION","FIRE BURNS","HAIR BREAKAGE","BALD HEAD","FIBROID","BLOOD BUILDING","CATARACTS","THROAT PROBLEM","LOSS OF VOICE","DIARRHEA","HEADACHE","FEVER","COMMON COLD","CONSTIPATION"];
String? val = list.first;
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: cureFirstRoute() ,
  ),
  );
}
class cureFirstRoute extends StatelessWidget {
  const cureFirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(


      backgroundColor: Color(0xFF5FB2FF),

      appBar:AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: Center(
            child: Text(
              'Health AI',
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      body:Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children:[
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFB0F1FF),borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(bottom: 20,left: 5,right: 5,top: 20),


                  height: 390,
                  alignment: Alignment.center,

                  child: Column(
                    children: [
                      SizedBox(height: 13.0,),

                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin:EdgeInsets.all(15.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),



                          child: Center(
                            child: ListTile(


                              title: Text("Please Enter Your Disease:",
                                style: TextStyle(fontSize:21.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                       ),
                      SizedBox(height: 13.0,),
                      Card(

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        elevation: 5,
                        color: Colors.white,

                        margin:EdgeInsets.all(15.0),



                          //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                          child: DropdownSearch<String>(


                            popupProps: PopupProps.menu(
                              showSelectedItems: true,

                            ),
                            items: ["TYPHOID FEVER","STOMACH ULCER","ASTHMA","RHEUMATISM / ARTHRITIS","CHOLERA","HIGH BLOOD PRESSURE","PNEUMONIA","SEVERE COUGH","TUBERCULOSIS","DIABETES","STAPHYLOCOCCUS","WOMAN UNDER HARD LABOUR","INTERNAL PILE","MENSTRUATION PROBLEM","WEIGHT LOSS","FUNGAL INFECTION","GONORRHEA","INTERNAL HEAT","INSOMNIA","HEART FAILURE","TEETHING PROBLEMS IN CHILDREN","LOW SPERM COUNT","QUICK EJACULATION","WEAK ERECTION","VIRGINAL DISCHARGE","CHILDREN CONVULSION","FIRE BURNS","HAIR BREAKAGE","BALD HEAD","FIBROID","BLOOD BUILDING","CATARACTS","THROAT PROBLEM","LOSS OF VOICE","DIARRHEA","HEADACHE","FEVER","COMMON COLD","CONSTIPATION"],
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10
                                ),
                                labelText: "Select Here",

                              ),
                            ),
                            onChanged: (data) {
                              print(data);
                              val=data;
                            },

                            selectedItem: "TYPHOID FEVER",


                          )


                        ),



                      SizedBox(height: 12),
                      ElevatedButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  cureSecondRoute(val: val)),
                        );
                      }, child: const Text('Search')),
                      SizedBox(height: 5),
                      ElevatedButton(onPressed: (){ Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BaseApp()),
                      );}, child: const Text('Return')),
                       ],
                     )




                  ),
                ),









            ],

          )


      ),

      drawer:  Navbar(),


    );
  }
}


















class cureSecondRoute extends StatefulWidget {
  const cureSecondRoute({super.key, required val});


  @override
  State<cureSecondRoute> createState() => _cureSecondRouteState();
}

class _cureSecondRouteState extends State<cureSecondRoute> {

  @override
  Widget build(BuildContext context) {
    String? s="";
    if(val=="TYPHOID FEVER"){s="Get unripe pawpaw, unripe pineapple, ginger, lime orange, and Lipton tea. Cut into pieces, boil with fermented corn water for one hour. Take one glass cup 3 times daily for one week. The ailment will disappear.";}
    if(val=="STOMACH ULCER"){s="Get 7-8 unripe plantain, peel them, cut them to pieces and pound. Put everything inside a plastic container, fill it with one gallon of water. Allow it to ferment for three days. Take one cup 2 times a day for one week. The ailment will disappear.";}
    if(val=="ASTHMA"){s="Get some seeds of mango, cut it into pieces and keep under the sun to dry. Grind to powder. Put one spoon of the powder into a glass cup of water, stir it and drink. Once in a day for 3-4 weeks.";}
    if(val=="RHEUMATISM / ARTHRITIS"){s="Get 5 seeds of English pear (Avocado pear), cut into pieces and dry under the sun, grind to a powder. Mix with a glass of honey to form a paste. Take one spoon,3 times daily until the 6 days.";}
    if(val=="CHOLERA"){s="Take three teaspoons of salt and one teaspoon of sugar, add half spoon of dry gin. Drink all as a single dose. Cholera will stop immediately with these home remedies tip";}
    if(val=="HIGH BLOOD PRESSURE"){s="Get 4 seeds of English pear (Avocado pear), cut into pieces, dry under the sun and grind into powder. Put a teaspoon of this powder into your prepared palp and drink. Once daily for 2 weeks.";}
    if(val=="PNEUMONIA"){s="Get a handful of garlic, grind to extract the juice. Drink a spoon and use the juice to rub the chest and back. That will close the chapter.";}
    if(val=="SEVERE COUGH"){s="Get about 10 pieces of bitter cola, grind to powder, add a half cup of original honey. Take 2 spoons thrice daily for 4 days.";}
    if(val=="TUBERCULOSIS"){s="Get 20-23 pieces of bitter cola, ginger of equal quantity and 3 bulbs of garlic. Grind everything and add a bottle of original honey. Take one spoon thrice daily for one month.";}
    if(val=="DIABETES"){s="Get a handful of bitter leaf and scent leaves, squeeze out the water in them, add lime(orange)juice, grinded garlic and small potash. Take half glass of it twice daily for one month.";}
    if(val=="STAPHYLOCOCCUS"){s="Get 2 pieces of aloe-vera, cut into pieces and put it in a container. Add one bottle of original honey and a glass of water. Take half a cup of it,2 times daily for one week.";}
    if(val=="WOMAN UNDER HARD LABOUR"){s="Get some leaves of Corchorus Olitorus(Vegetable Leaf), squeeze out the water and give it to the woman under hard labour. She will deliver the baby instantly.";}
    if(val=="INTERNAL PILE"){s="Get the leaves of pawpaw, scent leaves, and bitter leaves, squeeze out the water. Take half cup twice daily for 4 days.";}
    if(val=="MENSTRUATION PROBLEM"){s="Get 4-5 cola, ginger and garlic cut them in pieces. Mix it with lime orange juice. Take 2 spoons daily for 3 days.";}
    if(val=="WEIGHT LOSS"){s="Get some corn silk, boil with lime orange juice. Drink half a cup of it daily for one week and also embark on physical exercise.";}
    if(val=="FUNGAL INFECTION"){s="Mix a native soap with ground potash, add lime orange. Apply the mixture after a bath.";}
    if(val=="GONORRHEA"){s="One of the home remedies for gonorrhea is to get 3-4 pieces of cola, ginger, and garlic, cut into pieces. Mix everything with lime orange juice. Take 2 spoons daily until it is over.";}
    if(val=="INTERNAL HEAT"){s="Get some quantity of dry pawpaw leaves and cashew leaves, boil with water and drink a half cup daily for one week.";}
    if(val=="INSOMNIA"){s="Add 3 spoons of honey into a glass cup of milk. Take all at bedtime for one week.";}
    if(val=="HEART FAILURE"){s="Grind 12 bulbs of onions and 12 bulbs of garlic together. Get 3 bottles of honey, mix together. Take 2 spoons thrice daily for 2 weeks.";}
    if(val=="TEETHING PROBLEMS IN CHILDREN"){s="Get a mixture of lime juice and honey; let it be of equal quantity. The child should take one teaspoon twice daily until the problem is over.";}
    if(val=="LOW SPERM COUNT"){s="Get a large number of guava leaves, pound, add water and filter. Drink one glass cup thrice per day for 1 week. As you are taking that, eat carrot and cucumber daily for 2 weeks.";}
    if(val=="QUICK EJACULATION"){s="Get 3 bulbs of Okro, slice them; get the dry seed of it, ferment everything with soda water for 2 days. Take half cup daily for one week.";}
    if(val=="WEAK ERECTION"){s="Get 6 bulbs of white onions, grind and extract the juice. Mix the juice with honey. Take 2 spoons thrice daily for one week.";}
    if(val=="VIRGINAL DISCHARGE"){s="Get 3 pieces of bitter cola, some ginger and garlic, grind and add lime juice. Take 2 spoons twice daily for one week";}
    if(val=="CHILDREN CONVULSION"){s="Get one onion, small garlic, and ginger, grind all. Mix with palm kernel oil. Give the child to drink and use the mixture as a cream for the child.";}
    if(val=="FIRE BURNS"){s="One of the home remedies of fire burns is to rub the affected the area with pure honey daily.";}
    if(val=="HAIR BREAKAGE"){s="Get one bottle of olive oil and one bottle of honey. Mix together and warm it for a few minutes. Use the mixture to wash your hair.";}
    if(val=="BALD HEAD"){s="Grind bird pepper, unripe pawpaw seed and mix with lime orange juice. Use the mixture to rub the head, hair will start growing in the affected area.";}
    if(val=="FIBROID"){s="Eat about 20 pieces of unripe palm kernel seeds every day for about two months.";}
    if(val=="BLOOD BUILDING"){s="Get some quantity of pumpkin leaves and garden egg leaves, squeeze out the liquid, add milk. Drink it for three days; your blood will be boosted.";}
    if(val=="CATARACTS"){s="Apply the aloe vera gel to the affected eyes every night until the problem is over.";}
    if(val=="THROAT PROBLEM"){s="One of the home remedies for a throat problem is to eat a small quantity of ginger continuously for one week.";}
    if(val=="LOSS OF VOICE"){s="Get some okro bulbs, cut it into pieces and pound. Add small water and honey and drink thrice in a day. This is one of the home remedies that could help.";}
    if(val=="DIARRHEA"){s="Drinking water is the first step to rehydrating. A person can also to create an oral rehydration solution by mixing 1 liter of water with half a teaspoon of salt and 6 teaspoons of sugar. Consuming sugar and salt with water helps the intestines to absorb fluids more efficiently.";}
    if(val=="HEADACHE"){s="Some of the remedies are drinking water to avoid dehydration, taking magnesium supplements, applying a cold compress to your neck or head area and using essential oils like thyme or rosemary on your temples and forehead. You can also try doing some basic stretches to reduce the intensity of the headache.";}
    if(val=="FEVER"){s="Some of the remedies include drinking plenty of fluids to avoid dehydration, taking a lukewarm or tepid bath to help the body cool off. You can also try drinking lemon juice with lukewarm water or using apple cider vinegar.";}
    if(val=="COMMON COLD"){s="Some of these remedies include staying hydrated by drinking plenty of fluids, getting plenty of rest and using saline nasal drops or sprays to relieve nasal congestion. You can also try drinking warm liquids like chicken soup or tea with honey, taking zinc lozenges, or drinking a mixture of lemon, cinnamon and honey.";}
    if(val=="CONSTIPATION"){s="Some of these remedies include drinking plenty of water to avoid dehydration, eating foods high in fiber like whole-wheat pasta, barley, chickpeas, lentils and split peas, blackberries, raspberries, pears, artichoke hearts, brussels sprouts and chia seeds. You can also try taking a fiber supplement, eating prunes or drinking prune juice.";}





    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(



      backgroundColor: Color(0xFF5FB2FF),

      appBar:AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
          child: Center(
            child: Text(
              'Health AI',
              style: TextStyle(
                fontFamily: 'InknutAntiqua',
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      body:
      Padding(

          padding: const EdgeInsets.all(25.0),
          child: Column(
            children:[
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFB0F1FF),borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.only(bottom: 0,left: 5,right: 5,top: 0),


                  height: 600,
                  alignment: Alignment.center,

                  child: Column(
                    children: [
                      SizedBox(height: 15.0,),

                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                        color: Colors.white,
                        elevation: 5,
                        margin:EdgeInsets.all(12.0),
                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                        child: InkWell(
                          onTap: () {
                           print(val);
                          },
                          child: Center(
                            child: ListTile(

                              leading:Icon(Icons.sick_outlined,size:50.0,color: Colors.redAccent,),
                              title: Text(val!,
                                style: TextStyle(fontSize:16.0,color: Colors.black,fontWeight:FontWeight.bold,),textAlign: TextAlign.center,
                              ),
                              trailing:Icon(Icons.sick_outlined,size:50.0,color: Colors.redAccent,),
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),


                        ),),

                      SizedBox(height: 15.0,),
                      Card(

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color: Colors.white,
                        margin:EdgeInsets.all(15.0),

                        //padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 6.0),
                        child: Center(

                          child: ListTile(
                            leading:Icon(Icons.medical_information_outlined,size:50.0,color: Colors.redAccent,),


                            title: Center(


                              child:
                              Text(s!,
                                style: TextStyle(fontSize:16.0,color: Colors.black,fontWeight:FontWeight.bold),
                              ),


                            ),
                            contentPadding: EdgeInsets.all(15.0),
                          ),
                        ),


                      ),


                    ],
                  ),
                ),



              ),
              Center(
                child:Container(
                  margin: EdgeInsets.only(top: 35, bottom: 0),
                  child:


                  TextButton(


                    style: ButtonStyle(

                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)
                    ),

                    onPressed: () { Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BaseApp()),
                  ); },

                    child:

                    Text("Go Home",
                      style: TextStyle(fontSize:23.0,color: Colors.white,fontWeight:FontWeight.bold, ),
                    ),
                  ),
                ),
              )





            ],

          )


      ),

      drawer:  Navbar(),


    );


  }
}








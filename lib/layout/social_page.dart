import 'package:auction_app/bloc/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auction_app/dio.dart';
import 'package:social_media_flutter/widgets/icons.dart';
import 'package:social_media_flutter/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/locale/locale_bloc.dart';
List social_list=[];
class Social_page extends StatelessWidget {
  const Social_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.read<LocaleBloc>().lang ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(leading: IconButton( onPressed: (){
            Navigator.pop(context);
          },icon: context
              .read<LocaleBloc>()
              .lang
              ? Icon(Icons.arrow_forward_ios, color: Theme
              .of(context)
              .brightness == Brightness.dark ? Colors.white : Colors.black)
              : Icon(Icons.arrow_back_ios, color: Theme
              .of(context)
              .brightness == Brightness.dark ? Colors.white : Colors.black)),title: Text(context.read<LocaleBloc>().social), elevation: 0),

          body: StatefulBuilder(builder: (context,setstate){
            dio.get_data(url: "/social").then((value) {
              print(value?.data);
              setstate((){
                social_list = value?.data ;
              });
            });
            if(social_list == []){
              return CircularProgressIndicator();
            }
            else{
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              launchUrl(Uri.parse(social_list[index]["link"]));
                            },
                            borderRadius: BorderRadius.circular(50),
                            child: CircleAvatar(
                            radius: 40,
                            backgroundColor: main_red,
                            child: Image(image: NetworkImage(social_list[index]["photo"]),height: 50,width: 50)),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context,index){
                    return Container(width: double.infinity,height: 2,color: Colors.grey,);
                  },
                  itemCount: social_list.length);
            }
          })
      ),
    );
  }
}

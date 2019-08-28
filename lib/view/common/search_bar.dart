import 'package:zmz_app/compose/compose.dart';
import 'package:zmz_app/view/common/my_search.dart';

class SearchBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    var _searchValue = '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ActionChip(
          backgroundColor: Colors.white,
          avatar: Icon(Icons.search, color: Colors.grey),
          label: Container(
            alignment: Alignment.center,
            width: ZFit().setWidth(200),
            height: ZFit().setWidth(22),
            child: Text('搜索')
          ),
          onPressed: () {
            showSearch(
              context: context,
              query: _searchValue,
              delegate: MySearch(_searchValue)
            );
          },
        ),
        Container(
          child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: ZFit().setWidth(15)),
            minWidth: ZFit().setWidth(25),
            child: Text('提问', style: TextStyle(color: Colors.white, fontSize: ZFit().setSp(14))),
            onPressed: () {
              Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text("不给你提问."),
              ));
            }
          )
        )
      ],
    );
  }
}
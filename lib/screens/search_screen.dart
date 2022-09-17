import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/search_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final String searchValue; //上位Widgetから受け取りたいデータ
  const SearchScreen({Key? key, required this.searchValue}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var color_gray = '757575'; // アイコン、文字色

  final _sortMap = {0: "名前：昇順", 1: "名前：降順", 2: "かな：昇順", 3: "かな：降順"};
  var _selectedSortItem = 0;

  late String searchValue;

  @override
  void initState() {
    super.initState();

    // 受け取ったデータを状態を管理する変数に格納
    searchValue = widget.searchValue;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = SearchBarController();
        controller.init(searchValue);

        if (searchValue != "") {
          controller.isSearching = true;
        }

        return controller;
      },
      child: Consumer<SearchBarController>(
        builder: (BuildContext context, SearchBarController searchBarController,
            Widget? child) {
          if (searchBarController.isLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(HexColor(color_gray)),
                ),
              ),
            );
          }

          return Scaffold(
              key: searchBarController.globalKey,
              appBar: AppBar(
                centerTitle: true,
                title: _appBarTitle(searchBarController),
                actions: [
                  IconButton(
                    icon: _appbarIcon(searchBarController),
                    onPressed: searchBarController.isSearching
                        ? searchBarController.searchEnd
                        : searchBarController.searchStart,
                  ),
                ],
              ),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        // ソート用のドロップダウンリスト
                        child: _dropDownWidget(searchBarController)),
                    Flexible(
                      // 人物リスト
                      child: _listWidget(context, searchBarController),
                    ),
                  ]));
        },
      ),
    );
  }

  Widget _appbarIcon(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? Icon(
            Icons.close,
            color: HexColor(color_gray),
          )
        : Icon(
            Icons.search,
            color: HexColor(color_gray),
          );
  }

  Widget _appBarTitle(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? TextFormField(
            autofocus: true,
            cursorColor: HexColor(color_gray),
            style: TextStyle(
              color: HexColor(color_gray),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: HexColor(color_gray),
              ),
              hintText: '全文検索...',
              hintStyle: TextStyle(
                color: HexColor(color_gray),
              ),
            ),
            initialValue: searchValue, //ここに初期値
            onChanged: (word) {
              searchBarController.searchOperation(word);
            },
          )
        : Text(
            '検索リスト',
            style: TextStyle(
              color: HexColor(color_gray),
            ),
          );
  }

  Widget _dropDownWidget(SearchBarController searchBarController) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16), //全方向に１０
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center, //中央
              height: 80,
              color: Colors.yellow,
              child: DropdownButton(
                isExpanded: true,
                // elevation: 16,
                value: _selectedSortItem,
                onChanged: (newValue) {
                  setState(() {
                    _selectedSortItem = newValue as int;
                  });
                },
                items: _sortMap.entries.map((entry) {
                  return DropdownMenuItem(
                    alignment: Alignment.center, //中央
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              height: 80,
              width: 80, // 指定されても、Expanded に包まれると無視される
            ),
          ),
        ],
      ),
    );
  }

  Widget _listWidget(
      BuildContext context, SearchBarController searchBarController) {
    final itemList = (searchBarController.isSearching &&
            searchBarController.searchedText.isNotEmpty)
        ? searchBarController.searchedItemList
        : searchBarController.allItemList;

    if (itemList.isEmpty) {
      return Center(
        child: Text('"${searchBarController.searchedText}"を含む文字列は見つかりませんでした。'),
      );
    } else {
      return ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchDatailScreen(itemList[index], index)),
                  ),
                  leading: Hero(
                    tag: 'image${index}',
                    child: Image.network(
                      itemList[index].image,
                    ),
                  ),
                  title: Text(
                    itemList[index].name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(itemList[index].ruby),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        )
                      ];
                    },
                    onSelected: (String value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchDatailScreen(itemList[index], index)),
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }
}

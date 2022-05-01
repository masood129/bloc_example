import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/bloc.dart';
import 'package:untitled/model/model.dart';

void main() {
  runApp(
    BlocProvider<ProductBloc>(
      create: (context) => ProductBloc(),
      child: const MaterialApp(
        home: Home(),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("ممد فروشی به جز اصغر")),
        leading: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_basket_outlined,
                    size: 25,
                  )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: BlocBuilder<ProductBloc, ProductState>(
                    bloc: ProductBloc(),
                    builder: (context, state) => (state is LoadingProductState)
                        ? const CircularProgressIndicator()
                        : (state is SuccessProductState)
                            ? Text(
                                '${state.count}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : (state is ErrorProductState)
                                ? Tooltip(
                                    message: state.error.toString(),
                                    child: const Text('0'),
                                  )
                                : const Text('0'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder<List<Product>>(
            future: Product.loadData(),
            builder: (context, snap) => (snap.connectionState ==
                    ConnectionState.done)
                ? ListView.builder(
                    itemCount: snap.data!.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        onTap: () {},
                        title: Container(
                          height: 300,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Image(
                                  image:
                                      NetworkImage(snap.data![index].picurl!),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                  child: Text(
                                snap.data![index].name!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${snap.data![index].price}\$",
                                      style: TextStyle(
                                        color: (snap.data![index].off! > 0)
                                            ? Colors.red
                                            : Colors.black,
                                        decoration: (snap.data![index].off! > 0)
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    (snap.data![index].off! > 0)
                                        ? Text(
                                            "${((snap.data![index].price!) - (snap.data![index].price! * snap.data![index].off!)).toStringAsFixed(2)}\$",
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<ProductBloc>(context).add(
                                    AddProduct(
                                      prd: snap.data![index],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_basket_outlined,
                                    color: Colors.green),
                              ),
                              const SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
    );
  }
}

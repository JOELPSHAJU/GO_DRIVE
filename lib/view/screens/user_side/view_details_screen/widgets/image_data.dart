import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/view/bloc/search_inventory/search_inventory_bloc.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/widgets/image_viewer.dart';
import 'package:godrive/view/screens/user_side/profile_screen/profile_screen.dart';

class ImageData extends StatelessWidget {
  const ImageData({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final String userEmail = currentUser!.email.toString();

    return BlocConsumer<InventoryBloc, SearchInventoryState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        if (state is InventoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InventoryLoaded) {
          final data = state
              .inventoryList[index]; 
          List favourites =
              data['favourites'] ?? []; 

          bool isFavourite = favourites.contains(userEmail);

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ImageViewer(images: data['additionalImages']),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(.7),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 28,
                      ),
                      splashRadius: 28,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black.withOpacity(.7),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        if (isFavourite) {
                          BlocProvider.of<InventoryBloc>(context).add(
                            RemoveFromFavourites(data['id'], userEmail),
                          );
                        } else {
                          BlocProvider.of<InventoryBloc>(context).add(
                            AddToFavourites(data['id'], userEmail),
                          );
                        }
                      },
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: isFavourite ? Colors.red : Colors.white,
                        size: 28,
                      ),
                      splashRadius: 28,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is InventoryError) {
          return Center(child: Text('Error: '));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visual_notes/business_logic/item_bloc/items_bloc.dart';
import 'package:visual_notes/local/item.dart';
import 'package:visual_notes/repositories/image_repository.dart';
import 'package:visual_notes/ui/widgets/app_elevated_btn.dart';
import 'package:visual_notes/ui/widgets/app_text.dart';
import 'package:visual_notes/ui/widgets/app_text_field.dart';
import 'package:visual_notes/ui/widgets/image_widget.dart';
import 'package:visual_notes/utils/app_validators.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({
    Key? key,
    this.item,
  }) : super(key: key);
  final Item? item;

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _imgKey = GlobalKey();
  final GlobalKey<FormFieldState<DateTime>> _dateTimeKey = GlobalKey();
  final GlobalKey<FormFieldState<bool>> _isOpenKey = GlobalKey();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      _titleController.text = widget.item!.title;
      _descController.text = widget.item!.description;
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: AppText(text: widget.item != null ? 'Edit' : 'Add'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  _imageInput(),
                  SizedBox(height: 16.h),
                  _titleInput(),
                  _descInput(),
                  _dateTimeInput(),
                  _isOpenInput(),
                ],
              ),
            ),
            Builder(builder: (context) {
              return AppElevatedButton(
                child: const AppText(
                  text: 'Submit',
                ),
                onClicked: () {
                  debugPrint('${_formKey.currentState!.validate()}');
                  if (_formKey.currentState!.validate()) {
                    context.read<ItemsBloc>().add(
                          SaveItem(
                            Item(
                              id: DateTime.now().millisecondsSinceEpoch,
                              dateTime: _dateTimeKey.currentState!.value!,
                              description: _descController.text,
                              img: _imgKey.currentState!.value!,
                              status: _isOpenKey.currentState!.value!,
                              title: _titleController.text,
                            ),
                            widget.item != null ? ItemType.edit : ItemType.add,
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
              );
            })
          ],
        ),
      ),
    );
  }

  FormField<bool> _isOpenInput() {
    return FormField<bool>(
      initialValue: widget.item?.status ?? false,
      key: _isOpenKey,
      validator: (value) {
        if (value != null) {
          return null;
        }
        return 'required';
      },
      builder: (field) => InputDecorator(
        decoration: InputDecoration(
          isDense: true,
          errorText: field.errorText,
          border: InputBorder.none,
          errorMaxLines: 1,
        ),
        child: CheckboxListTile(
          value: field.value,
          isThreeLine: false,
          onChanged: (value) {
            field.didChange(value);
          },
          title: const AppText(text: 'is opened'),
        ),
      ),
    );
  }

  SizedBox _dateTimeInput() {
    return SizedBox(
      height: 0.2.sh,
      child: FormField<DateTime>(
        key: _dateTimeKey,
        validator: (value) {
          if (value == null) {
            return 'Required';
          }
          return null;
        },
        initialValue: widget.item?.dateTime,
        builder: (field) => InputDecorator(
          decoration: InputDecoration(
            errorText: field.errorText,
            errorMaxLines: 1,
            border: InputBorder.none,
            isDense: true,
          ),
          child: CupertinoDatePicker(
            initialDateTime: field.value,
            mode: CupertinoDatePickerMode.dateAndTime,
            onDateTimeChanged: (value) {
              field.didChange(value);
            },
          ),
        ),
      ),
    );
  }

  AppTextField _descInput() {
    return AppTextField(
      label: 'Desc',
      textEditingController: _descController,
      validator: (value) => AppValidator.validatorRequired(value, context),
    );
  }

  AppTextField _titleInput() {
    return AppTextField(
      label: 'Title',
      textEditingController: _titleController,
      validator: (value) => AppValidator.validatorRequired(value, context),
    );
  }

  Widget _imageInput() {
    return Builder(
      builder: (context) {
        return FormField(
          key: _imgKey,
          initialValue: widget.item?.img,
          validator: (value) {
            if (value == null) {
              return 'Required';
            }
            return null;
          },
          builder: (FormFieldState<String?> field) => InputDecorator(
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              errorMaxLines: 1,
              errorText: field.errorText,
            ),
            child: ItemImage(
              onClicked: () async {
                final repository = ImageRepository();
                final value = await repository.getImage();
                field.didChange(value?.path);
              },
              imagePath: field.value,
            ),
          ),
        );
      },
    );
  }
}

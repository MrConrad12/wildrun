// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class cardDataAdapter extends TypeAdapter<cardData> {
  @override
  final int typeId = 3;

  @override
  cardData read(BinaryReader reader) {
    return cardData();
  }

  @override
  void write(BinaryWriter writer, cardData obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is cardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

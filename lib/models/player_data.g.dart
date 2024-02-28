// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerDataAdapter extends TypeAdapter<PlayerData> {
  @override
  final int typeId = 0;

  @override
  PlayerData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerData()
      ..highScore = fields[1] as int
      ..maxDistance = fields[2] as int
      ..totalDistance = fields[3] as int
      ..maxTree = fields[4] as int
      ..totalTree = fields[5] as int
      ..maxAnimal = fields[6] as int
      ..totalAnimal = fields[7] as int
      ..maxWaste = fields[8] as int
      ..totalWaste = fields[9] as int
      ..maxEnemy = fields[10] as int
      ..totalEnemy = fields[11] as int;
  }

  @override
  void write(BinaryWriter writer, PlayerData obj) {
    writer
      ..writeByte(11)
      ..writeByte(1)
      ..write(obj.highScore)
      ..writeByte(2)
      ..write(obj.maxDistance)
      ..writeByte(3)
      ..write(obj.totalDistance)
      ..writeByte(4)
      ..write(obj.maxTree)
      ..writeByte(5)
      ..write(obj.totalTree)
      ..writeByte(6)
      ..write(obj.maxAnimal)
      ..writeByte(7)
      ..write(obj.totalAnimal)
      ..writeByte(8)
      ..write(obj.maxWaste)
      ..writeByte(9)
      ..write(obj.totalWaste)
      ..writeByte(10)
      ..write(obj.maxEnemy)
      ..writeByte(11)
      ..write(obj.totalEnemy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

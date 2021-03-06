import 'dart:math' as math;
import 'dart:typed_data';

/**
 * @Copyright  2020 © John Melody Me
 * Licensed under the John Melody Me, Version 1.0 (the "License");
 * you may not use this file except in compliance with the License.
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

final math.Random _r = new math.Random.secure();

int randomInt(int max) {
  int r;
  do {
    r = _randomInt(max.bitLength);
  } while (r >= max);
  return r;
}

int _randomInt(int numBits) {
  List<int> bytes = _randomBytes(numBits);
  int r = 0;
  for (final b in bytes) {
    r = (r << 8) + b;
  }
  return r;
}

List<int> _randomBytes(int numBits) {
  if (numBits < 0) {
    throw new ArgumentError.value(numBits, 'numBits must be non-negative');
  }

  int numBytes = (numBits + 7) ~/ 8;
  Uint8List randomBytes = new Uint8List(numBytes);

  for (var i = 0; i < randomBytes.length; i++) {
    randomBytes[i] = _r.nextInt(255);
  }
  // Mask out any excess bits
  int excessBits = 8 * numBytes - numBits;
  randomBytes[0] &= (1 << (8 - excessBits)) - 1;

  return randomBytes;
}
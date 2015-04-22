module Bwt;

import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.stdio;
import std.string;

class MoveToFrontDecoder
{
private:
  long[] _encoded;
  string[] _minValueSet;

public:
  this(long[] encoded, string[] minValueSet)
  {
    _encoded = encoded;
    _minValueSet = minValueSet;
  }

  string decode()
  {
    auto buffer = _minValueSet.dup();
    string[] decoded = [];

    foreach (code; _encoded)
    {
      decoded ~= buffer[code];

      if (code > 0)
      {
        auto c = moveAt(buffer, code);
        buffer = c ~ buffer;
      }
    }

    return decoded.join();
  }
}

unittest
{
  assert(new MoveToFrontDecoder([2, 0, 2, 2, 0, 0], ["a", "b", "n"]).decode()
    == "nnbaaa");
}

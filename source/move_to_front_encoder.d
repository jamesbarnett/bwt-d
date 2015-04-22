module Bwt;

import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.stdio;
import std.string;

class MoveToFrontEncoder
{
private:
  string _str;
  string[] _minValueSet;

public:
  this(string str)
  {
    _str = str;
    _minValueSet = findMinValueSet();
  }

  long[] encode()
  {
    long[] encoded = [];
    auto buffer = _minValueSet.dup();

    for (int i = 0; i < _str.length; ++i)
    {
      encoded ~= countUntil(buffer, to!string(_str[i]));

      if (encoded[$-1] > 0)
      {
        auto c = moveAt(buffer, encoded[$-1]);
        buffer = c ~ buffer;
      }
    }

    return encoded;
  }

private:
  string[] findMinValueSet()
  {
    string[] cs = [];

    foreach (char c; _str)
    {
      writeln("c: ", c);
      if (countUntil(cs[], to!string(c)) == -1)
      {
        cs ~= [c];
      }
    }

    return sort(cs).array();
  }
}

unittest
{
  assert(new MoveToFrontEncoder("nnbaaa").encode() == [2, 0, 2, 2, 0, 0]);
}

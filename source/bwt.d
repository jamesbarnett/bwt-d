module bwt;

import std.stdio;
import std.algorithm;
import std.container;
import std.conv;
import std.range;
import std.typecons;

mixin template Bwt()
{
  string rotate(string str, int index = 0) {
    return str[index+1 .. $] ~ str[0 .. index+1];
  }

  SortedRange!(string[]) sortedPermutations(string str)
  {
    string[] ps = [str];

    for (int i = 0; i < str.length - 1; i++)
    {
      ps ~= rotate(str, i);
    }

    return ps.sort();
  }

  string lastColumn(SortedRange!(string[]) ps)
  {
    return array(map!(a => a[$-1 .. $])(ps)).join();
  }

  Tuple!(string, long) encode(string str)
  {
    auto ps = sortedPermutations(str);
    string lc = lastColumn(ps);
    long index = countUntil(ps, str);
    return Tuple!(string, long)(lc, index);
  }

  string decode(Tuple!(string, long) encoded)
  {
    string[] ps = [""];
    long pindex = 0;

    while (any!(a => a.length < encoded[0].length)(ps))
    {
      for (int i = 0; i < encoded[0].length; ++i)
      {
        if (ps.length <= pindex)
        {
          ps ~= "";
          writeln("ps: ", ps);
        }
        ps[pindex] = encoded[0][i] ~ ps[pindex];
        ++pindex;
      }

      pindex = 0;
      sort(ps);
    }

    return ps[encoded[1]];
  }
}

unittest
{
  mixin Bwt;
  assert(rotate("banana", 0) == "ananab");
  auto ps = sortedPermutations("banana");
  assert(sortedPermutations("banana").length == "banana".length);
  assert(lastColumn(ps) == "nnbaaa");
  assert(encode("banana") == Tuple!(string, long)("nnbaaa", 3));
  assert(decode(Tuple!(string, long)("nnbaaa", 3)) == "banana");
}

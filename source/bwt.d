module bwt;

import std.stdio;
import std.algorithm;
import std.range;

mixin template Bwt() {
  string rotate(string str, int index = 0) {
    return str[index+1 .. $] ~ str[0 .. index+1];
  }

  SortedRange!(string[]) sortedPermutations(string str) {
    string[] ps = [str];

    for (int i = 0; i < str.length - 1; i++) {
      ps ~= rotate(str, i);
    }

    return sort(ps);
  }

  string lastColumn(SortedRange!(string[]) ps) {
    return join(map!(x => x[$])(ps));
  }
}


unittest {
  mixin Bwt;
  assert(rotate("banana", 0) == "ananab");
  auto ps = sortedPermutations("banana");
  assert(sortedPermutations("banana").length == "banana".length);
  string lc = lastColumn(ps);

  /*foreach (string p; ps) {
    writeln("lastColumn(ps) = ", lc);
  }*/
}

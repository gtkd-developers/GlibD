/*
 * This file is part of gtkD.
 *
 * gtkD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version, with
 * some exceptions, please read the COPYING file.
 *
 * gtkD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with gtkD; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA
 */

import gobject.DClosure;
import gobject.Value;
import gio.FileInfo;

static void foo() {}

struct Baz
{
	void opCall() {}
}

void main()
{
	DClosure closure;
	FileInfo info = new FileInfo();

	void bar() {}
	Baz baz;

	closure = new DClosure(&foo);
	closure = new DClosure(&bar);
	closure = new DClosure(baz);

	bool test(char c, int i, float f, string s, FileInfo o)
	{
		assert(c == 't');
		assert(i == 10);
		assert(f == 0x1.99999ap-3f);
		assert(s == "test");
		assert(o is info);

		return true;
	}

	closure = new DClosure(&test);
	Value[] params = [new Value('t'), new Value(10), new Value(0x1.99999ap-3f), new Value("test"), new Value(info)];
	Value ret = new Value();
	ret.init(GType.BOOLEAN);

	closure.invoke(ret, params, null);

	assert(ret.gType == GType.BOOLEAN);
	assert(ret.get!bool == true);
}

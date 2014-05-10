/*
** font-binding.cpp
**
** This file is part of mkxp.
**
** Copyright (C) 2013 Jonas Kulla <Nyocurio@gmail.com>
**
** mkxp is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 2 of the License, or
** (at your option) any later version.
**
** mkxp is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with mkxp.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "font.h"
#include "binding-util.h"
#include "binding-types.h"
#include "exception.h"
#include "sharedstate.h"

#include <string.h>

DEF_TYPE(Font);

RB_METHOD(fontDoesExist)
{
	RB_UNUSED_PARAM;

	const char *name;
	rb_get_args(argc, argv, "z", &name RB_ARG_END);

	return rb_bool_new(Font::doesExist(name));
}

RB_METHOD(FontSetName);

RB_METHOD(fontInitialize)
{
	VALUE name = Qnil;
	int size = 0;

	rb_get_args(argc, argv, "|oi", &name, &size RB_ARG_END);

	Font *f = new Font(0, size);

	setPrivateData(self, f);

	/* Wrap property objects */
	f->setColor(new Color(*f->getColor()));
	wrapProperty(self, f->getColor(), "color", ColorType);

	if (NIL_P(name))
		name = rb_iv_get(rb_obj_class(self), "default_name");

	/* Going over the 'name=' function automatically causes
	 * a possbile name array to be re-verified for existing fonts */
	FontSetName(1, &name, self);

	return self;
}

RB_METHOD(fontInitializeCopy)
{
	VALUE origObj;
	rb_get_args(argc, argv, "o", &origObj RB_ARG_END);

	if (!OBJ_INIT_COPY(self, origObj))
		return self;

	Font *orig = getPrivateData<Font>(origObj);
	Font *f = new Font(*orig);
	setPrivateData(self, f);

	/* Wrap property objects */
	f->setColor(new Color(*f->getColor()));
	wrapProperty(self, f->getColor(), "color", ColorType);

	return self;
}

RB_METHOD(FontGetName)
{
	RB_UNUSED_PARAM;

	return rb_iv_get(self, "name");
}

static void
fontSetNameHelper(VALUE self, int argc, VALUE *argv,
                  const char *nameIv, char *outBuf, size_t outLen)
{
	rb_check_argc(argc, 1);

	VALUE arg = argv[0];
	int type = rb_type(arg);

	// Fixme: in RGSS3, specifying "" (and only that) as font name results in
	// no text being drawn (everything else is substituted with Arial I think)
	strncpy(outBuf, "", outLen);

	if (type == T_STRING)
	{
		strncpy(outBuf, RSTRING_PTR(arg), outLen);
	}
	else if (type == T_ARRAY)
	{
		for (long i = 0; i < RARRAY_LEN(arg); ++i)
		{
			VALUE str = rb_ary_entry(arg, i);

			/* Non-string objects are tolerated (ignored) */
			if (rb_type(str) != T_STRING)
				continue;

			const char *family = RSTRING_PTR(str);

			/* We only set the core Font object's name attribute
			 * to the actually existing font name */
			if (!shState->fontState().fontPresent(family))
				continue;

			strncpy(outBuf, family, outLen);
		}
	}

	/* RMXP doesn't even care if the argument type is
	 * something other than string/array. Whatever... */
	rb_iv_set(self, nameIv, arg);
}

RB_METHOD(FontSetName)
{
	Font *f = getPrivateData<Font>(self);

	char result[256];
	fontSetNameHelper(self, argc, argv, "default_name",
	                  result, sizeof(result));

	f->setName(result);

	return argv[0];
}

#undef DEF_PROP_CHK_DISP
#define DEF_PROP_CHK_DISP

DEF_PROP_I(Font, Size)
DEF_PROP_B(Font, Bold)
DEF_PROP_B(Font, Italic)
DEF_PROP_OBJ(Font, Color, Color, "color")

#define DEF_KLASS_PROP(Klass, type, PropName, param_t_s, value_fun) \
	RB_METHOD(Klass##Get##PropName) \
	{ \
		RB_UNUSED_PARAM; \
		return value_fun(Klass::get##PropName()); \
	} \
	RB_METHOD(Klass##Set##PropName) \
	{ \
		RB_UNUSED_PARAM; \
		type value; \
		rb_get_args(argc, argv, param_t_s, &value RB_ARG_END); \
		Klass::set##PropName(value); \
		return value_fun(value); \
	}

DEF_KLASS_PROP(Font, int, DefaultSize, "i", rb_fix_new)
DEF_KLASS_PROP(Font, bool, DefaultBold, "b", rb_bool_new)
DEF_KLASS_PROP(Font, bool, DefaultItalic, "b", rb_bool_new)

RB_METHOD(FontGetDefaultName)
{
	RB_UNUSED_PARAM;

	return rb_iv_get(self, "default_name");
}

RB_METHOD(FontSetDefaultName)
{
	char result[256];
	fontSetNameHelper(self, argc, argv, "default_name",
	                  result, sizeof(result));

	Font::setDefaultName(result);

	return argv[0];
}

RB_METHOD(FontGetDefaultColor)
{
	RB_UNUSED_PARAM;
	return rb_iv_get(self, "default_color");
}


RB_METHOD(FontSetDefaultColor)
{
	VALUE colorObj;
	rb_get_args(argc, argv, "o", &colorObj RB_ARG_END);

	Color *c = getPrivateDataCheck<Color>(colorObj, ColorType);

	Font::setDefaultColor(c);
	rb_iv_set(self, "default_color", colorObj);

	return colorObj;
}

#define INIT_KLASS_PROP_BIND(Klass, PropName, prop_name_s) \
{ \
	rb_define_class_method(klass, prop_name_s, Klass##Get##PropName); \
	rb_define_class_method(klass, prop_name_s "=", Klass##Set##PropName); \
}

void
fontBindingInit()
{
	INIT_TYPE(Font);

	VALUE klass = rb_define_class("Font", rb_cObject);
	rb_define_alloc_func(klass, classAllocate<&FontType>);

	Font::setDefaultColor(new Color(*Font::getDefaultColor()));
	wrapProperty(klass, Font::getDefaultColor(), "default_color", ColorType);
	rb_iv_set(klass, "default_name", rb_str_new2(Font::getDefaultName()));

	INIT_KLASS_PROP_BIND(Font, DefaultName, "default_name");
	INIT_KLASS_PROP_BIND(Font, DefaultSize, "default_size");
	INIT_KLASS_PROP_BIND(Font, DefaultBold, "default_bold");
	INIT_KLASS_PROP_BIND(Font, DefaultItalic, "default_italic");
	INIT_KLASS_PROP_BIND(Font, DefaultColor, "default_color");

	rb_define_class_method(klass, "exist?", fontDoesExist);

	_rb_define_method(klass, "initialize",      fontInitialize);
	_rb_define_method(klass, "initialize_copy", fontInitializeCopy);

	INIT_PROP_BIND(Font, Name, "name");
	INIT_PROP_BIND(Font, Size, "size");
	INIT_PROP_BIND(Font, Bold, "bold");
	INIT_PROP_BIND(Font, Italic, "italic");
	INIT_PROP_BIND(Font, Color, "color");
}

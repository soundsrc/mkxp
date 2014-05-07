/**
 * OpenAL cross platform audio library
 * Copyright (C) 1999-2007 by authors.
 * This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Library General Public
 *  License as published by the Free Software Foundation; either
 *  version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 *  License along with this library; if not, write to the
 *  Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 *  Boston, MA  02111-1307, USA.
 * Or go to http://www.gnu.org/copyleft/lgpl.html
 */

#include "config.h"

#include <stdlib.h>
#include <string.h>
#include "alMain.h"
#include "AL/al.h"
#include "AL/alc.h"
#include "AL/alext.h"


///////////////////////////////////////////////////////


static ALCmallocFunc alcMallocFunc = malloc;
static ALCreallocFunc alcReallocFunc = realloc;
static ALCfreeFunc alcFreeFunc = free;

AL_API ALCvoid AL_APIENTRY alcAllocatorEXT(ALCmallocFunc mallocFunc,ALCreallocFunc reallocFunc,ALCfreeFunc freeFunc)
{
	alcMallocFunc = mallocFunc;
    alcReallocFunc = reallocFunc;
    alcFreeFunc = freeFunc;
}

void *alMalloc(size_t size)
{
    return alcMallocFunc(size);
}

void *alRealloc(void *ptr,size_t size)
{
    return alcReallocFunc(ptr,size);
}

void *alCalloc(size_t count,size_t size)
{
    size_t allocSize = count * size;
	void *ptr = alMalloc(allocSize);
    if(ptr) memset(ptr,0,allocSize);
    return ptr;
}

void alFree(void *ptr)
{
    alcFreeFunc(ptr);
}

///////////////////////////////////////////////////////

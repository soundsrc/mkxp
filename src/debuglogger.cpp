/*
** debuglogger.cpp
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

#include "debuglogger.h"
#include "debugwriter.h"

#include <GL/glew.h>
#include <iostream>

struct DebugLoggerPrivate
{
	std::ostream *stream;

	DebugLoggerPrivate(const char *logFilename)
	{
		(void) logFilename;

		stream = &std::clog;
	}

	~DebugLoggerPrivate()
	{
	}

	void writeTimestamp()
	{
		// FIXME reintroduce proper time stamps (is this even necessary??)
		*stream << "[GLDEBUG] ";
	}

	void writeLine(const char *line)
	{
		*stream << line << "\n";
		stream->flush();
	}
};

static void amdDebugFunc(GLuint id,
                         GLenum category,
	                     GLenum severity,
	                     GLsizei length,
	                     const GLchar* message,
	                     GLvoid* userParam)
{
	DebugLoggerPrivate *p = static_cast<DebugLoggerPrivate*>(userParam);

	(void) id;
	(void) category;
	(void) severity;
	(void) length;

	p->writeTimestamp();
	p->writeLine(message);
}

static void arbDebugFunc(GLenum source,
                         GLenum type,
                         GLuint id,
                         GLenum severity,
                         GLsizei length,
                         const GLchar* message,
                         GLvoid* userParam)
{
	DebugLoggerPrivate *p = static_cast<DebugLoggerPrivate*>(userParam);

	(void) source;
	(void) type;
	(void) id;
	(void) severity;
	(void) length;

	p->writeTimestamp();
	p->writeLine(message);
}

DebugLogger::DebugLogger(const char *filename)
{
	p = new DebugLoggerPrivate(filename);

	if (GLEW_KHR_debug)
		glDebugMessageCallback(arbDebugFunc, p);
	else if (GLEW_ARB_debug_output)
		glDebugMessageCallbackARB(arbDebugFunc, p);
	else if (GLEW_AMD_debug_output)
		glDebugMessageCallbackAMD(amdDebugFunc, p);
	else
		Debug() << "DebugLogger: no debug extensions found";
}

DebugLogger::~DebugLogger()
{
	delete p;
}

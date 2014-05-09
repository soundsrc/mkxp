/*
** shader.cpp
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

#include "shader.h"
#include "sharedstate.h"
#include "glstate.h"
#include "exception.h"

#include <GL/glew.h>

#include <assert.h>
#include <iostream>

#include "../sprite.frag.xxd"
#include "../hue.frag.xxd"
#include "../trans.frag.xxd"
#include "../transSimple.frag.xxd"
#include "../bitmapBlit.frag.xxd"
#include "../plane.frag.xxd"
#include "../simple.frag.xxd"
#include "../simpleColor.frag.xxd"
#include "../simpleAlpha.frag.xxd"
#include "../flashMap.frag.xxd"
#include "../simple.vert.xxd"
#include "../simpleColor.vert.xxd"
#include "../sprite.vert.xxd"

#ifdef RGSS2
#include "../blur.frag.xxd"
#include "../simpleMatrix.vert.xxd"
#include "../blurH.vert.xxd"
#include "../blurV.vert.xxd"
#endif


#define INIT_SHADER(vert, frag, name) \
{ \
	Shader::init(shader_##vert##_vert, shader_##vert##_vert_len, shader_##frag##_frag, shader_##frag##_frag_len, \
	#vert, #frag, #name); \
}

#define GET_U(name) u_##name = glGetUniformLocation(program, #name)

static void printShaderLog(GLuint shader)
{
	GLint logLength;
	glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLength);

	std::string log(logLength, '\0');
	glGetShaderInfoLog(shader, log.size(), 0, &log[0]);

	std::clog << "Shader log:\n" << log;
}

static void printProgramLog(GLuint program)
{
	GLint logLength;
	glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);

	std::string log(logLength, '\0');
	glGetProgramInfoLog(program, log.size(), 0, &log[0]);

	std::clog << "Program log:\n" << log;
}

Shader::Shader()
{
	vertShader = glCreateShader(GL_VERTEX_SHADER);
	fragShader = glCreateShader(GL_FRAGMENT_SHADER);

	program = glCreateProgram();
}

Shader::~Shader()
{
	glUseProgram(0);
	glDeleteProgram(program);
	glDeleteShader(vertShader);
	glDeleteShader(fragShader);
}

void Shader::bind()
{
	glState.program.set(program);
}

void Shader::unbind()
{
	glActiveTexture(GL_TEXTURE0);
	glState.program.set(0);
}

void Shader::init(const unsigned char *vert, int vertSize,
                  const unsigned char *frag, int fragSize,
                  const char *vertName, const char *fragName,
                  const char *programName)
{
	GLint success;

	/* Compile vertex shader */
	glShaderSource(vertShader, 1, (const GLchar**) &vert, (const GLint*) &vertSize);
	glCompileShader(vertShader);

	glGetObjectParameterivARB(vertShader, GL_COMPILE_STATUS, &success);

	if (!success)
	{
		printShaderLog(vertShader);
		throw Exception(Exception::MKXPError,
	                    "GLSL: An error occured while compiling vertex shader '%s' in program '%s'",
	                    vertName, programName);
	}

	/* Compile fragment shader */
	glShaderSource(fragShader, 1, (const GLchar**) &frag, (const GLint*) &fragSize);
	glCompileShader(fragShader);

	glGetObjectParameterivARB(fragShader, GL_COMPILE_STATUS, &success);

	if (!success)
	{
		printShaderLog(fragShader);
		throw Exception(Exception::MKXPError,
	                    "GLSL: An error occured while compiling fragment shader '%s' in program '%s'",
	                    fragName, programName);
	}

	/* Link shader program */
	glAttachShader(program, vertShader);
	glAttachShader(program, fragShader);

	glBindAttribLocation(program, Position, "position");
	glBindAttribLocation(program, TexCoord, "texCoord");
	glBindAttribLocation(program, Color, "color");

	glLinkProgram(program);

	glGetObjectParameterivARB(program, GL_LINK_STATUS, &success);

	if (!success)
	{
		printProgramLog(program);
		throw Exception(Exception::MKXPError,
	                    "GLSL: An error occured while linking program '%s' (vertex '%s', fragment '%s')",
	                    programName, vertName, fragName);
	}
}

void Shader::initFromFile(const char *_vertFile, const char *_fragFile,
                          const char *programName)
{
	std::string vertContents, fragContents;
	readFile(_vertFile, vertContents);
	readFile(_fragFile, fragContents);

	init((const unsigned char*) vertContents.c_str(), vertContents.size(),
	     (const unsigned char*) fragContents.c_str(), fragContents.size(),
	     _vertFile, _fragFile, programName);
}

void Shader::setVec4Uniform(GLint location, const Vec4 &vec)
{
	glUniform4f(location, vec.x, vec.y, vec.z, vec.w);
}

void Shader::setTexUniform(GLint location, unsigned unitIndex, TEX::ID texture)
{
	GLenum texUnit = GL_TEXTURE0 + unitIndex;

	glActiveTexture(texUnit);
	glBindTexture(GL_TEXTURE_2D, texture.gl);
	glUniform1i(location, unitIndex);
	glActiveTexture(GL_TEXTURE0);
}

void ShaderBase::GLProjMat::apply(const Vec2i &value)
{
	/* glOrtho replacement */
	const float a = 2.f / value.x;
	const float b = 2.f / value.y;
	const float c = -2.f;

	GLfloat mat[16] =
	{
		 a,  0,  0,  0,
		 0,  b,  0,  0,
		 0,  0,  c,  0,
		-1, -1, -1,  1
	};

	glUniformMatrix4fv(u_mat, 1, GL_FALSE, mat);
}

void ShaderBase::init()
{
	GET_U(texSizeInv);
	GET_U(translation);

	projMat.u_mat = glGetUniformLocation(program, "projMat");
}

void ShaderBase::applyViewportProj()
{
	const IntRect &vp = glState.viewport.get();
	projMat.set(Vec2i(vp.w, vp.h));
}

void ShaderBase::setTexSize(const Vec2i &value)
{
	glUniform2f(u_texSizeInv, 1.f / value.x, 1.f / value.y);
}

void ShaderBase::setTranslation(const Vec2i &value)
{
	glUniform2f(u_translation, value.x, value.y);
}


SimpleShader::SimpleShader()
{
	INIT_SHADER(simple, simple, SimpleShader);

	ShaderBase::init();

	GET_U(texOffsetX);
}

void SimpleShader::setTexOffsetX(int value)
{
	glUniform1f(u_texOffsetX, value);
}


SimpleColorShader::SimpleColorShader()
{
	INIT_SHADER(simpleColor, simpleColor, SimpleColorShader);

	ShaderBase::init();
}


SimpleAlphaShader::SimpleAlphaShader()
{
	INIT_SHADER(simpleColor, simpleAlpha, SimpleAlphaShader);

	ShaderBase::init();
}


SimpleSpriteShader::SimpleSpriteShader()
{
	INIT_SHADER(sprite, simple, SimpleSpriteShader);

	ShaderBase::init();

	GET_U(spriteMat);
}

void SimpleSpriteShader::setSpriteMat(const float value[16])
{
	glUniformMatrix4fv(u_spriteMat, 1, GL_FALSE, value);
}


TransShader::TransShader()
{
	INIT_SHADER(simple, trans, TransShader);

	ShaderBase::init();

	GET_U(currentScene);
	GET_U(frozenScene);
	GET_U(transMap);
	GET_U(prog);
	GET_U(vague);
}

void TransShader::setCurrentScene(TEX::ID tex)
{
	setTexUniform(u_currentScene, 0, tex);
}

void TransShader::setFrozenScene(TEX::ID tex)
{
	setTexUniform(u_frozenScene, 1, tex);
}

void TransShader::setTransMap(TEX::ID tex)
{
	setTexUniform(u_transMap, 2, tex);
}

void TransShader::setProg(float value)
{
	glUniform1f(u_prog, value);
}

void TransShader::setVague(float value)
{
	glUniform1f(u_vague, value);
}


SimpleTransShader::SimpleTransShader()
{
	INIT_SHADER(simple, transSimple, SimpleTransShader);

	ShaderBase::init();

	GET_U(currentScene);
	GET_U(frozenScene);
	GET_U(prog);
}

void SimpleTransShader::setCurrentScene(TEX::ID tex)
{
	setTexUniform(u_currentScene, 0, tex);
}

void SimpleTransShader::setFrozenScene(TEX::ID tex)
{
	setTexUniform(u_frozenScene, 1, tex);
}

void SimpleTransShader::setProg(float value)
{
	glUniform1f(u_prog, value);
}


SpriteShader::SpriteShader()
{
	INIT_SHADER(sprite, sprite, SpriteShader);

	ShaderBase::init();

	GET_U(spriteMat);
	GET_U(tone);
	GET_U(color);
	GET_U(opacity);
	GET_U(bushDepth);
	GET_U(bushOpacity);
}

void SpriteShader::setSpriteMat(const float value[16])
{
	glUniformMatrix4fv(u_spriteMat, 1, GL_FALSE, value);
}

void SpriteShader::setTone(const Vec4 &tone)
{
	setVec4Uniform(u_tone, tone);
}

void SpriteShader::setColor(const Vec4 &color)
{
	setVec4Uniform(u_color, color);
}

void SpriteShader::setOpacity(float value)
{
	glUniform1f(u_opacity, value);
}

void SpriteShader::setBushDepth(float value)
{
	glUniform1f(u_bushDepth, value);
}

void SpriteShader::setBushOpacity(float value)
{
	glUniform1f(u_bushOpacity, value);
}


PlaneShader::PlaneShader()
{
	INIT_SHADER(simple, plane, PlaneShader);

	ShaderBase::init();

	GET_U(tone);
	GET_U(color);
	GET_U(flash);
	GET_U(opacity);
}

void PlaneShader::setTone(const Vec4 &tone)
{
	setVec4Uniform(u_tone, tone);
}

void PlaneShader::setColor(const Vec4 &color)
{
	setVec4Uniform(u_color, color);
}

void PlaneShader::setFlash(const Vec4 &flash)
{
	setVec4Uniform(u_flash, flash);
}

void PlaneShader::setOpacity(float value)
{
	glUniform1f(u_opacity, value);
}


FlashMapShader::FlashMapShader()
{
	INIT_SHADER(simpleColor, flashMap, FlashMapShader);

	ShaderBase::init();

	GET_U(alpha);
}

void FlashMapShader::setAlpha(float value)
{
	glUniform1f(u_alpha, value);
}


HueShader::HueShader()
{
	INIT_SHADER(simple, hue, HueShader);

	ShaderBase::init();

	GET_U(hueAdjust);
	GET_U(inputTexture);
}

void HueShader::setHueAdjust(float value)
{
	glUniform1f(u_hueAdjust, value);
}

void HueShader::setInputTexture(TEX::ID tex)
{
	setTexUniform(u_inputTexture, 0, tex);
}


#ifdef RGSS2

SimpleMatrixShader::SimpleMatrixShader()
{
	INIT_SHADER(simpleMatrix, simpleAlpha, SimpleMatrixShader);

	ShaderBase::init();

	GET_U(matrix);
}

void SimpleMatrixShader::setMatrix(const float value[16])
{
	glUniformMatrix4fv(u_matrix, 1, GL_FALSE, value);
}


BlurShader::HPass::HPass()
{
	INIT_SHADER(blurH, blur, BlurShader::HPass);

	ShaderBase::init();
}

BlurShader::VPass::VPass()
{
	INIT_SHADER(blurV, blur, BlurShader::VPass);

	ShaderBase::init();
}

#endif


BltShader::BltShader()
{
	INIT_SHADER(simple, bitmapBlit, BltShader);

	ShaderBase::init();

	GET_U(source);
	GET_U(destination);
	GET_U(subRect);
	GET_U(opacity);
}

void BltShader::setSource()
{
	glUniform1i(u_source, 0);
}

void BltShader::setDestination(const TEX::ID value)
{
	setTexUniform(u_destination, 1, value);
}

void BltShader::setSubRect(const FloatRect &value)
{
	glUniform4f(u_subRect, value.x, value.y, value.w, value.h);
}

void BltShader::setOpacity(float value)
{
	glUniform1f(u_opacity, value);
}

# $FreeBSD$

PORTNAME=	ros-rosdep
DISTVERSION=	0.11.8
CATEGORIES=	devel

MAINTAINER=	trentonw@ifi.uio.no
COMMENT=	Multi-package manager system dependency tool for ROS

LICENSE=	BSD3CLAUSE

WWW=	http://docs.ros.org/independent/api/rosdep/html/
USES=	python
USE_PYHTON=	distutils autoplist
USE_GITHUB=	yes
GH_ACCOUNT=	ros-infrastructure
GH_PROJECT=	rosdep
GH_TAGNAME=	0.11.8

do-install:
	(cd ${WRKSRC} && python setup.py install --root ${STAGEDIR})

.include <bsd.port.mk>

Security Policy
===============

Supported Versions
------------------
Currently maintained versions receiving security updates:

.. list-table::
   :header-rows: 1
   :widths: 20 80

   * - Version
     - Support Status
   * - X.Y
     - Active maintenance
   * - X.Y
     - Critical fixes only
   * - < X.Y
     - Unsupported

Reporting Vulnerabilities
-------------------------
**Please report security issues responsibly** through our secure channel:

.. list-table::
   :widths: 30 70
   :header-rows: 0

   * - **Preferred Method**
     - Create private vulnerability report through GitHub Security Advisories
   * - **Alternative**
     - Email security team at ``epilif3sotnas@yandex.com`` when using this method please in the subject put the name of project
   * - **Response Time**
     - Initial acknowledgment within 48 hours

**Do not** report security vulnerabilities through public issues, discussions, or pull requests.

Disclosure Policy
-----------------
1. **Verification**: Security team confirms the vulnerability
2. **Patch Development**: Team creates fixes for supported versions
3. **Coordinated Disclosure**:
   - Security advisory published
   - CVE assigned (if applicable)
   - Patch releases issued simultaneously

Security Updates
----------------
Regular security improvements are implemented through:

* **Dependency scanning** for known vulnerabilities
* **Automated security testing** in CI/CD pipelines
* **Third-party audits** for critical components